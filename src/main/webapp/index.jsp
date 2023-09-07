<%@ page import="com.study.connection.ConnectionTest" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="views/boards/free/common/header.jsp" %>
<section id="content">
    <h2 align="center" style="margin-top:200px;">안녕하세요, 메인페이지 입니다.</h2>
</section>
<a href="hello-servlet">Hello Servlet</a>
<%

    ConnectionTest t = new ConnectionTest();
    out.println(t.getConnection());

%>
<%@ include file="views/boards/free/common/footer.jsp" %>