const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/post', (req, res) => {
  const currentPage = parseInt(req.query.page || '1');
  const category = req.query.category;

  const limit = 10;
  const offset = (currentPage - 1) * limit;

  let query, params;
  if (!category) {
    query = `SELECT *, DATE_FORMAT(created_at, '%Y.%m.%d %H:%m:%s') created_at
            FROM post
            ORDER BY created_at DESC
            LIMIT ? OFFSET ?`;
    params = [limit, offset];
  } else {
    query = `SELECT post.*, category.category_name
            FROM post
            JOIN category ON post.category_id = category.category_id
            WHERE category.category_name = ?
            LIMIT ? OFFSET ?`;
    params = [category, limit, offset];
  }

  connection.query(query, params, (err, result) => {
    if (err) {
      console.error('가져오기 에러: ', err.message);
      return res.status(500).send('데이터베이스 에러');
    }

    if (result.length === 0) {
      return res.status(404).json({ message: '데이터 없음' });
    }

    res.json(result);
  });
});

router.get('/post/:id', (req, res) => {
  const id = req.params.id;
  let query = `SELECT * FROM post WHERE post_id = ?`;

  connection.query(query, [id], (err, result) => {
    if (err) {
      console.error('가져오기 에러: ', err.message);
      return res.status(500).send('데이터베이스 에러');
    }

    if (result.length === 0) {
      return res.status(404).json({ message: '데이터 없음' });
    }

    res.json(result);
  });
});

module.exports = router;
