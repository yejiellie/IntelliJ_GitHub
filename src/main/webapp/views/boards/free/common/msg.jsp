<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<html>
<head>
    <title>메세지 페이지</title>
</head>
<body>
<script>
    alert('${msg}');                        //알림
    location.replace("${path}${loc}");      //페이지로 이동
</script>
</body>
</html>
