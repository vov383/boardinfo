<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
  <div id="footer">
    <div class="footerMain">
      서울특별시 강남구 테헤란로14길 6 남도빌딩 2,3F<br>
      KH정보교육원 TEAM BOARDINFO
    </div>
    <div class="footerSub">
      <div class="footerSubLeft"></div>
      <div class="footerSubCenter"></div>
      <div class="footerSubRight">
          <button id="adminLoginBtn">관리자 로그인</button>
      </div>
    </div>
  </div>
</footer>

<script>
  const adminLoginBtn = document.getElementById("adminLoginBtn");
  adminLoginBtn.addEventListener("click", function () {
    location.href = "${path}/admin/admin_login.do";
  });
</script>