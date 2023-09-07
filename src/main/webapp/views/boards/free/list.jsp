<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="common/header.jsp" %>
<style>
    section#board-container{width:600px; margin:0 auto; text-align:center;}
    section#board-container h2{margin:10px 0;}
    table#tbl-board{width:100%; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
    table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;}
    /*글쓰기버튼*/
    input#btn-add{float:right; margin: 0 0 15px;}
    /*페이지바*/
    div#pageBar{margin-top:10px; text-align:center; background-color:rgba(0, 188, 212, 0.3);}
    div#pageBar span.cPage{color: #0066ff;}
</style>
<section id="board-container">
    <h2>자유 게시판 - 목록 </h2>
    <p>총 @@@건</p>
    <table id="tbl-board">
        <tr>
            <th>카테고리</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>등록일시</th>
            <th>수정일시</th>
        </tr>
        <tr>
            <td>번호</td>
            <td>
                타이틀을 누르면 상세화면으로 이동
            </td>
            <td></td>
            <td></td>
            <td>
                첨부파일이 있으면 이미지출력 / 없으면 공란
            </td>
            <td></td>
        </tr>
    </table>
</section>
<%@ include file="common/footer.jsp" %>