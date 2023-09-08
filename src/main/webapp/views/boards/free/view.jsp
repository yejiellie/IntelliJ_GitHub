<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/header.jsp" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page import="com.study.dao.CategoryDao" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.vo.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.study.vo.BoardComment" %>
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
        /*border-bottom: 1px solid;*/
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
        padding-top: 10px;
        /*border-bottom: 1px solid;*/
        /*border-top: 1px solid;*/
    }
    #filearea {
        /*border: 1px solid tomato;*/
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

    int boardNo=Integer.parseInt(request.getParameter("boardNo"));

    BoardDao dao=new BoardDao();
    Board b=dao.viewDtail(boardNo); //게시글 상세보기
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd HH:mm"); //날짜 출력방식
    String createday=formatter.format(b.getCreateDay());
    String updateday="-";
    if(b.getUpdateDay()!=null){
        updateday=formatter.format(b.getUpdateDay());
    }
%>
<div style="padding: 20px">
    <h2>게시판 - 보기</h2>
    <div id="pageunder">
        <p><%=b.getWriter()%></p>
        <div id="insertdate">
            <p>등록일시 : <%=createday%></p>
            <p>수정일시 : <%=updateday%></p>
        </div>
    </div>
    <div id="titlecate">
        <div style="display: flex; font-weight: bold">
            <p>[
            <% if(!clist.isEmpty()){
                for(Category c : clist){
            %>
            <%=b.getCategory()==c.getCateNo()?c.getCateName():""%>
            <%
                    }
                }
            %>]
            </p>
            <p style="margin-left: 20px"><%=b.getTitle()%></p>
        </div>
        <div id="readcount">
            <p>조회수 : <%=b.getBoardCount()%></p>
        </div>
    </div>
    <hr class="my-hr" />
    <pre id="contetnarea"><%=b.getContent()%></pre>
    <div id="filearea">
        (첨부파일 위치)
    </div>

<%
    List<BoardComment> boardComment=dao.listComment();
%>
<%--댓글--%>
    <section id="board-container">
        <div style="background-color: rgb(236, 234, 234)">
            <%
                if(!boardComment.isEmpty()){
                    for(BoardComment bc : boardComment){
                        if(bc.getBoardNo()==boardNo){
                        String day=formatter.format(bc.getCommentDate());
            %>
            <div id="tbl-comment">
                <sub class="comment-date"><%=day%></sub>
                <sub class="comment"><%=bc.getContent()%></sub>
            </div>
            <hr>
            <%
                        }
                    }
                }
            %>
            <div class="comment-editor">
                <form action="<%=request.getContextPath()%>/views/boards/free/insertComment.jsp" method="post" onsubmit="return insertComment();">
                    <textarea id="comment" name="comment" cols="80" rows="3" placeholder="댓글을 입력해주세요"></textarea>
                    <input type="hidden" name="boardNo" value="<%=boardNo%>">
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
    <script>
        const insertComment=()=>{
            if($("#comment").val().trim()==""){
                $("#comment").val('');
                $("#comment").focus();
                alert("댓글 내용을 입력해주세요");
                return false;

            }
        }
    </script>
</div>



<%@ include file="common/footer.jsp" %>