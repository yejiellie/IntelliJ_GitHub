<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/views/boards/free/common/header.jsp"/>
<style>
    section#board-container {
        margin: 0 auto;
        text-align: center;
    }
    table#tbl-board {
        width: 100%;
        margin: 0 auto;
        border-top: 1px solid black;
        border-collapse: collapse;
        clear: both;
    }
    table#tbl-board th,
    table#tbl-board td {
        border-bottom: 1px solid;
        padding: 10px 0;
        text-align: center;
    }
    div#pageBar {
        padding-top: 50px;
        text-align: center;
    }
    div#pageBar span.cPage {
        color: #1d6403;
    }

    #searchdata {
        border: 1px solid black;
        padding: 10px;
        margin-bottom: 10px;
    }
    #searchbox {
        width: 300px;
        height: 20px;
    }
    #totalsearch {
        float: right;
    }
    .pl {
        width: 120px;
        height: 25px;
    }
    #btn-search {
        background-color: black;
        color: white;
        width: 70px;
    }
    #beforeDate,#currentDate{
        margin-left: 20px;
        margin-right: 20px;
    }
</style>


<div style="padding: 20px;">
    <h2 style="padding-bottom: 20px">자유 게시판 - 목록</h2>
    <form action="${path}/views/boards/free/searchInfo.jsp" method="get">
        <div id="searchdata">
            등록일 <input type="date" id="beforeDate" />~<input type="date" id="currentDate"/>
            <div id="totalsearch">
                <select name="likeLanguage" id="" class="pl">
                    <option selected disabled>카테고리 선택</option>
                    <%--카테고리 전체 내용을 출력 --%>
                    <c:if test="${!categoryList.isEmpty()}">
                        <c:forEach var="cateList" items="${categoryList}">
                            <option value="${cateList.cateNo}">${cateList.cateName}</option>
                        </c:forEach>
                    </c:if>
                </select>
                <input type="text" id="searchbox" placeholder="검색어를 입력해주세요.(제목+작성자+내용)"/>
                <input type="submit" id="btn-search" value="검색" />
            </div>
        </div>
    </form>

    <script>
        //input태그 현재 날짜 디폴트값
        document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
        var now = new Date();
        //input 태그 1년전으로 설정
        document.getElementById('beforeDate').value = new Date(now.setFullYear(now.getFullYear() - 1)).toISOString().substring(0, 10);
    </script>

    <p>총 ${totalData}건</p>

    <section id="board-container">
        <table id="tbl-board">
            <tr>
                <th>카테고리</th>
                <th></th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>등록일시</th>
                <th>수정일시</th>
            </tr>
<%--                        //날짜 형식을 바꿔줌--%>
<%--                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd HH:mm");--%>
<%--                        String createday=formatter.format(b.getCreateDay());--%>
<%--                        String updateday="-";--%>
<%--                        if(b.getUpdateDay()!=null){--%>
<%--                            updateday=formatter.format(b.getUpdateDay());--%>
<%--                        }--%>
<%--                        String title="";--%>
<%--                        //제목이 80자가 넘는경우 ...으로 대체지만 너무 길어서 30자로 대체--%>
<%--                        if(b.getTitle().length()>=30) {--%>
<%--                            title = b.getTitle().substring(0, 30).concat("...");--%>
            <c:if test="${!list.isEmpty()}">
                <c:forEach var="b" items="${list}">
                <tr id="tableinfo">
                    <td>
                        <c:if test="${!categoryList.isEmpty()}">
                            <c:forEach var="c" items="${categoryList}">
                                ${c.cateNo eq b.cateNo?c.cateName:""}
                            </c:forEach>
                        </c:if>
                    </td>
                    <td><c:out value="${b.file!=null?'📎':''}"/></td>
                    <td><a href="${path}/views/boards/free/view.jsp?boardNo=${b.boardNo}">${fn:length(b.title) ge 30?fn:substring(b.title,0,30)+="...":b.title}</a></td>
                    <td>${b.writer}</td>
                    <td>${b.boardCount}</td>
                    <td><fmt:formatDate type="both" value="${b.createDay}" /></td>
                    <td><fmt:formatDate type="both" value="${b.updateDay}"/></td>
                </tr>
                </c:forEach>
            </c:if>
        </table>

<%--        <div id="pageBar">${pageBar}</div>--%>
        <div style="float: right; padding: 50px">
            <input type="button" onclick="insertbaord();" value="등록" style="width: 90px" />
        </div>
        <script>
            const insertbaord=()=>{
                location.href="${path}/views/boards/free/write.jsp";
            }
        </script>
    </section>
</div>
<jsp:include page="/views/boards/free/common/footer.jsp"/>