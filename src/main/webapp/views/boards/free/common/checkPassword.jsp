<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.dao.BoardDao" %>
<html>
<head>
    <title>비밀번호 확인하기</title>
    <script	src="<%=request.getContextPath()%>/js/jquery-3.6.1.min.js"></script>
</head>
<body>
<%
    int boardNo=Integer.parseInt(request.getParameter("boardNo"));
    Board b=new BoardDao().viewDtail(boardNo); //게시글 상세보기

%>
<div style="display: flex; border: 1px solid black; width: 350px; margin: 30px">
    <div style="padding: 10px;width: 150px;
          background-color: rgb(236, 234, 234);
          text-align: center;">비밀번호<strong style="color: red">*</strong>
    </div>
    <div>
        <input style="margin: 10px; width: 200px" type="text" id="checkPw" placeholder="비밀번호를 입력해주세요"/>
        <input type="hidden" id="nowPw" value="<%=b.getBoardPw()%>">
    </div>
</div>
<div style="width: 350px; text-align: center; margin-left: 30px">
    <input type="button" value="닫기" style="width: 80px" onclick="window.close();" />
    <input type="button" value="확인" onclick="passCheck();"
           style="width: 80px; background-color: black; color: white"/>
</div>
<script>
    const passCheck=()=>{
        const check=$("#checkPw").val();
        const newPassword=$("#nowPw").val();
        console.log(check);
        console.log(newPassword);
        if(newPassword!=check){
            alert("비밀번호가 일치하지 않습니다.");
        }else{
            opener.location.replace('<%=request.getContextPath()%>/views/boards/free/modify.jsp?boardNo='+<%=boardNo%>);close();
        }
    }

</script>

</body>
</html>
