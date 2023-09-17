<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/views/boards/free/common/header.jsp"/>
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
        /*justify-content: space-between;*/
        height: auto;
        padding-top: 20px;
        /*padding-bottom: 10px;*/
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
        font-size: 13px;
        /*white-space: break-spaces;*/
    }
</style>
<div style="padding: 20px">
    <h2>게시판 - 보기</h2>
    <div id="pageunder">
        <p>${b.writer}</p>
        <div id="insertdate">
            <p>등록일시 : <fmt:formatDate type="both" value="${b.createDay}" /></p>
            <p>수정일시 :
                <c:if test="${b.updateDay eq null}">
                    -
                </c:if>
                <c:if test="${not empty b.updateDay}">
                    <fmt:formatDate type="both" value="${b.updateDay}"/>
                </c:if>
            </p>
        </div>
    </div>
    <div id="titlecate" style="display: flex; font-weight: bold">
        <div style="width: 10%">
        [
            <c:if test="${!categoryList.isEmpty()}">
                <c:forEach var="c" items="${categoryList}">
                    ${c.cateNo eq b.cateNo?c.cateName:""}
                </c:forEach>
            </c:if>
        ]
        </div>
        <div style="width: 80%">
            ${b.title}
        </div>
        <div style="width: 10%; text-align: right;margin-top: 1%;" id="readcount">
            조회수 : ${b.boardCount}
        </div>
    </div>
    <hr class="my-hr" />
    <pre id="contetnarea">${b.content}</pre>
    <div id="filearea">
        (첨부파일 위치)
    </div>

<%--댓글--%>
    <section id="board-container">
        <div style="background-color: rgb(236, 234, 234)">
            <c:if test="${not empty boardComment}">
                <c:forEach var="bc" items="${boardComment}">
                    <c:if test="${boardNo eq bc.boardNo}">
                        <div id="tbl-comment">
                            <sub class="comment-date"><fmt:formatDate type="both" value="${bc.commentDate}" /></sub>
                            <sub class="comment">${bc.content}</sub>
                        </div>
                        <hr>
                    </c:if>
                </c:forEach>
            </c:if>
            <div class="comment-editor">
                <form action="${path}/comment/CommentWrite" method="post" onsubmit="return insertComment();">
                    <textarea id="comment" name="comment" cols="80" rows="3" placeholder="댓글을 입력해주세요"></textarea>
                    <input type="hidden" name="boardNo" value="${boardNo}">
                    <button type="submit" id="btn-insert">등록</button>
                </form>
            </div>
        </div>
        <div id="totalbtn">
            <button onclick="location.assign('${path}/board/BoardList.do')">목록</button>
            <button onclick="updateBoard()">수정</button>
            <button onclick="deleteBoard()">삭제</button>
        </div>
    </section>
    <script>
        //댓글 내용 체크
        const insertComment=()=>{
            if($("#comment").val().trim()==""){
                $("#comment").val('');
                $("#comment").focus();
                alert("댓글 내용을 입력해주세요");
                return false;
            }
        }
        //수정하기
        const updateBoard=()=>{
            open("${path}/board/CheckPassword.do?boardNo=${boardNo}&type=update",
                "_blank","width=500,height=250");
        }
        //삭제하기
        const deleteBoard=()=>{
            open("${path}/board/CheckPassword.do?boardNo=${boardNo}&type=delete",
                "_blank","width=500,height=250");
        }
    </script>
</div>
<jsp:include page="/views/boards/free/common/footer.jsp"/>