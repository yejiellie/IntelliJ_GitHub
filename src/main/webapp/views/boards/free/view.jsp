<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/header.jsp" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page import="com.study.dao.CategoryDao" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.vo.Category" %>
<%@ page import="java.util.List" %>
<style>
    #insertdate {
        justify-content: flex-end;
        display: flex;
    }
    #insertdate > p {
        margin-left: 20px;
        margin-right: 20px;
    }
    #pageunder {
        display: flex;
        height: 30px;
        justify-content: space-between;
        font-size: 13px;
    }
    #titlecate {
        display: flex;
        justify-content: space-between;
        height: 40px;
    }
    #totalbtn > button {
        width: 90px;
        background-color: white;
        margin-top: 10px;
    }
    .my-hr {
        border: 0;
        height: 2px;
        background: #000000;
    }
    section#board-container {
        margin: 0 auto;
        text-align: center;
    }
    #btn-insert {
        width: 60px;
        height: 50px;
        color: white;
        background-color: #6f4fee;
        position: relative;
        top: -20px;
    }

    #tbl-comment {
        border-bottom: 1px solid;
        padding: 10px;
        text-align: left;
        line-height: 120%;
        display: flex;
        flex-direction: column;
    }
    .comment-date {
        font-size: 10px;
    }
    .comment-editor {
        margin-top: 10px;
        border-bottom: 1px solid;
    }
    #filearea {
        border: 1px solid tomato;
        padding-bottom: 50px;
        margin: 20px;
    }
    #contetnarea {
        width: 100%;
        margin: 20px;
    }
    #readcount {
        font-size: 5px;
        white-space: break-spaces;
    }
</style>
<%
    CategoryDao cdao=new CategoryDao();
    List<Category> clist=cdao.selectAll(); //전체 카테고리 호출

    BoardDao dao=new BoardDao();
    List<Board> list=dao.searchAll();  //전체 게시글 호출

%>
<div style="padding: 20px">
    <h2>게시판 - 보기</h2>
    <div id="pageunder">
        <p>작성자명</p>
        <div id="insertdate">
            <p>등록일시 : xxx.xxx</p>
            <p>수정일시 : -</p>
        </div>
    </div>
    <div id="titlecate">
        <div style="display: flex; font-weight: bold">
            <p>[카테고리 출력]</p>
            <p style="margin-left: 20px">제목 출력</p>
        </div>
        <div id="readcount">
            <p>조회수 : 1</p>
        </div>
    </div>
    <hr class="my-hr" />
    <pre id="contetnarea">게시판에 내용이 출력됩니다.</pre>
    <div id="filearea"></div>
    <section id="board-container">
        <div style="background-color: rgb(236, 234, 234)">
            <div id="tbl-comment">
                <sub class="comment-date">날짜</sub>
                <sub class="comment">내용</sub>
            </div>
            <div class="comment-editor">
                <form action="" method="post">
                    <textarea name="content" cols="80" rows="3"></textarea>
                    <button type="submit" id="btn-insert">등록</button>
                </form>
            </div>
        </div>
        <div id="totalbtn">
            <button onclick="location.assign('<%=request.getContextPath()%>/views/boards/free/list.jsp')">목록</button>
            <button>수정</button>
            <button>삭제</button>
        </div>
    </section>
</div>



<%@ include file="common/footer.jsp" %>