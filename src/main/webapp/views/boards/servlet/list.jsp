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
    <%--  검색 기능  --%>
    <form name="searchBox-form" id="searchBox-form" autocomplete="off">
        <div id="searchdata">
            등록일 <input type="date" id="beforeDate" name="beforeDate"/>~<input type="date" id="currentDate" name="currentDate"/>
            <div id="totalsearch">
                <select name="cateNo" id="cateNo" class="pl">
                    <option disabled>카테고리 선택</option>
                    <c:if test="${!categoryList.isEmpty()}">
                        <c:forEach var="cateList" items="${categoryList}">
                            <option value="${cateList.cateNo}">${cateList.cateName}</option>
                        </c:forEach>
                    </c:if>
                </select>
                <input type="text" id="searchbox" name="searchbox" placeholder="검색어를 입력해주세요.(제목+작성자+내용)"/>
                <input type="button" onclick="call_ajax()" id="btn-search" value="검색" />
            </div>
        </div>
    </form>

    <script>
        //input태그 현재 날짜 디폴트값
        document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
        var now = new Date();
        //input 태그 1년전으로 설정
        document.getElementById('beforeDate').value = new Date(now.setFullYear(now.getFullYear() - 1)).toISOString().substring(0, 10);

        //검색기능
        function call_ajax(){
            if($('#searchbox').val().length === 0){
                alert("검색어를 입력해주세요")
            }else{
                $.ajax({
                    type: 'GET',
                    url : "/board/searchBoard.do",
                    data : $("#searchBox-form").serialize(),   //폼태그 안에 데이터를 직렬화해서 보냄
                    success : function(result) {
                        //테이블 정보 초기화
                        $('#tbl-board > tbody').empty();
                        let str = "";
                        if (result.length > 0) {
                            var data = JSON.parse(result);      //JSON을 객체로 변경
                            for (let i=0;i<data.length;i++) {
                                str += '<tr>';
                                str += "<td>" + data[i].cateNo + "</td>";
                                str += "<td>" + "" + "</td>";
                                if(data[i].title.length>30){
                                    var title = data[i].title.substring(0,30)+"...";
                                    str += "<td><a href='/board/boardDetail.do?boardNo=" + data[i].boardNo + "'>" + title + "</a></td>";
                                }else{
                                    str += "<td><a href='/board/boardDetail.do?boardNo=" + data[i].boardNo + "'>" + data[i].title + "</a></td>";
                                }
                                str += "<td>" + data[i].writer + "</td>";
                                str += "<td>" + data[i].boardCount + "</td>";
                                str += "<td>" + data[i].createDay + "</td>";
                                if(data[i].updateDay != null){
                                    str += "<td>" + data[i].updateDay + "</td>";
                                }else{
                                    str += "<td>" + "-" + "</td>";
                                }
                                console.log(data[i].updateDay);
                                str += "</tr>";
                            }
                            //총 게시물 수
                            $('#total').html("<p id='total'>총 " + data.length + " 건" + "</p>")
                        }else{
                            str += "<tr><td>결과가 없습니다.</td></tr>";
                            $('#total').html("<p id='total'>총 0 건</p>")
                        }
                        //ajax페이지 처리는....
                        $('#pageBar').html("<div></div>");
                        $('#tbl-board > tbody').append(str);
                    }
                })
            }
        }
    </script>

    <p id="total">총 ${totalData}건</p>

    <section id="board-container">
        <table id="tbl-board">
            <thead>
                <tr>
                    <th>카테고리</th>
                    <th></th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>등록일시</th>
                    <th>수정일시</th>
                </tr>
            </thead>
            <tbody>
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
                    <td><c:out value="${empty b.file?'':'📎'}"/></td>
                    <td><a href="${path}/board/boardDetail.do?boardNo=${b.boardNo}">${fn:length(b.title) ge 30?fn:substring(b.title,0,30)+="...":b.title}</a></td>
                    <td>${b.writer}</td>
                    <td>${b.boardCount}</td>
                    <td><fmt:formatDate type="both" value="${b.createDay}" /></td>
                    <td>
                        <c:if test="${b.updateDay eq null}">
                            -
                        </c:if>
                        <c:if test="${not empty b.updateDay}">
                            <fmt:formatDate type="both" value="${b.updateDay}"/>
                        </c:if>

                    </td>
                </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>


        <div id="pageBar">${pageBar}</div>
        <div style="float: right; padding: 50px">
            <input type="button" onclick="insertbaord();" value="등록" style="width: 90px" />
        </div>
        <script>
            const insertbaord=()=>{
                location.href="${path}/board/boardWritePage.do";
            }
        </script>
    </section>
</div>
<jsp:include page="/views/boards/free/common/footer.jsp"/>