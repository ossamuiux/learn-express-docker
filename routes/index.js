const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  // console.log(req.app.get('port'), '포트번호');
  console.log(req.body, '요청본문');
  console.log(req.ip, '요청ip');
  console.log(req.params, '경로 매개변수');
  console.log(req.query, '쿼리 매개변수');

  if (!req.signedCookies.name) {
    // 일반쿠키
    // 크롬 - 어플리케이션 - 쿠키에서 확인
    // 크롬 maxage는 UTC이므로 +9해야 한국 시간, 다른탭으로 이동후 삭제 확인
    res.cookie('name', 'express_cookie', {
      // maxAge: 1000 * 60 * 60 * 24, // 유효기간 1일
      maxAge: 1000 * 60, // 유효기간 1분
      httpOnly: true, // js로 접근 못하게 하는 보안속성
      secure: false, // http에서도 쿠키 전송
      signed: true, // 쿠키값에 서명 추가하여 변조 방지
    });
  } else {
    // 쿠키가 존재할 경우, 브라우저 새로고침하여 두번째 요청에서 확인
    console.log(req.signedCookies, '서명된 쿠키');
    console.log(req.session, '세션 쿠키');
  }

  res.send('hello, express !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
});

module.exports = router;
