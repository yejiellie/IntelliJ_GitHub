<%@ page import="com.study.connection.ConnectionTest" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="views/boards/free/common/header.jsp" %>
<section id="content">
    <h2 align="center" style="margin-top:200px;">안녕하세요, 메인페이지 입니다.</h2>
    <ol type="1">
        <li>Model_1방식으로 게시판 만들기</li>
        <li>Servlet방식으로 게시판 만들기 (jstl사용, mybatis)</li>
        <li>Spring boot방식으로 게시판 만들기(Thymeleaf사용)</li>
    </ol>

</section>
<a href="hello-servlet">Hello Servlet</a>
<%

    ConnectionTest t = new ConnectionTest();
    out.println(t.getConnection());

%>

<%@ include file="views/boards/free/common/footer.jsp" %>