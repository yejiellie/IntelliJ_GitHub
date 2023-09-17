<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<html>
<head>
    <title>비밀번호 확인하기</title>
    <script	src="${path}/js/jquery-3.6.1.min.js"></script>
</head>
<body>

<div style="display: flex; border: 1px solid black; width: 350px; margin: 30px">
    <div style="padding: 10px;width: 150px;
          background-color: rgb(236, 234, 234);
          text-align: center;">비밀번호<strong style="color: red">*</strong>
    </div>
    <div>
        <input style="margin: 10px; width: 200px" type="text" id="checkPw" placeholder="비밀번호를 입력해주세요"/>
        <input type="hidden" id="nowPw" value="${b.boardPw}">
    </div>
</div>
<div style="width: 350px; text-align: center; margin-left: 30px">
    <input type="button" value="닫기" style="width: 80px" onclick="window.close();" />
    <input type="button" value="확인" onclick="passCheck();"
           style="width: 80px; background-color: black; color: white"/>
</div>
<input type="hidden" id="type" value="${type}">
<script>
    const passCheck=()=>{
        const check = $("#checkPw").val();
        const newPassword = $("#nowPw").val();
        const type = $("#type").val();
        if(newPassword!=check){
            alert("비밀번호가 일치하지 않습니다.");
        }else{
            if(type == 'update'){
                opener.location.replace('${path}/board/BoardUpdatePage.do?boardNo='+${boardNo});close();
            }else{
                opener.location.replace('${path}/board/DeleteBoard.do?boardNo='+${boardNo});close();
            }
        }
    }

</script>

</body>
</html>
