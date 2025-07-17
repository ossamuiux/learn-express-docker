const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/post', (req, res) => {
  const currentPage = parseInt(req.query.page || '1');
  const category = req.query.category;

  const limit = 10;
  const offset = (currentPage - 1) * limit;

  let query, params, countQuery, countParams;

  if (!category) {
    countQuery = `SELECT COUNT(*) AS total FROM post`;
    query = `SELECT post_id, category_id, title, views,
            DATE_FORMAT(created_at, '%Y.%m.%d %H:%i:%s') format_date
            FROM post
            ORDER BY created_at DESC
            LIMIT ? OFFSET ?`;
    params = [limit, offset];
    countParams = [];
  } else {
    countQuery = `SELECT COUNT(*) AS total
                  FROM post
                  JOIN category ON post.category_id = category.category_id
                  WHERE category.category_name = ?`;
    query = `SELECT post.post_id, post.category_id, post.title, post.views, category.category_name,
            DATE_FORMAT(created_at, '%Y.%m.%d %H:%i:%s') format_date
            FROM post
            JOIN category ON post.category_id = category.category_id
            WHERE category.category_name = ?
            ORDER BY post.created_at DESC
            LIMIT ? OFFSET ?`;
    params = [category, limit, offset];
    countParams = [category];
  }

  connection.query(countQuery, countParams, (countErr, countResult) => {
    if (countErr) {
      console.error('데이터 갯수 조회 에러: ', countErr.message);
      return res.status(500).send('데이터베이스 에러');
    }

    const total = countResult[0]?.total;

    connection.query(query, params, (err, result) => {
      if (err) {
        console.error('데이터 가져오기 에러: ', err.message);
        return res.status(500).send('데이터베이스 에러');
      }

      if (result.length === 0) {
        return res.status(404).json({ message: '데이터 없음' });
      }

      res.json({ total, data: result });
    });
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
