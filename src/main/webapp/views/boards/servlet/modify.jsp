<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/views/boards/free/common/header.jsp"/>
<style>
    #tbl-board {
        width: 100%;
        border-collapse: collapse;
    }
    table#tbl-board th {
        border-bottom: 1px solid;
        border-top: 1px solid;
        background-color: rgb(236, 234, 234);
    }
    table#tbl-board td {
        border-bottom: 1px solid;
        border-top: 1px solid;
        padding: 5px 0 5px 10px;
    }
    #filearea {
        display: flex;
        flex-direction: column;
    }
    #filearea > input {
        padding: 5px;
    }
    #btn {
        display: flex;
        justify-content: space-between;
        padding: 50px;
    }
    #btn > input {
        width: 90px;
    }
</style>

<div style="padding: 20px">
    <h2 style="padding-bottom: 20px">게시판 - 수정</h2>
    <div id="board-container">
        <form name="enrollBoard" action="${path}/board/BoardUpdate.do"
              method="post" onsubmit="return checkinsert();">
            <table id="tbl-board">
                <tr>
                    <th>카테고리</th>
                    <td>
                        <c:if test="${!categoryList.isEmpty()}">
                            <c:forEach var="c" items="${categoryList}">
                                ${c.cateNo eq b.cateNo?c.cateName:""}
                            </c:forEach>
                        </c:if>
                        <input type="hidden" name="boardNo" value="${boardNo}">
                    </td>
                </tr>
                <tr>
                    <th>등록일시</th>
                    <td><input type="text" value="${b.createDay}" readonly style="width: 200px;border: none;outline: none;" />
                    </td>
                </tr>
                <tr>
                    <th>수정일시</th>
                    <td>
                        <c:if test="${b.updateDay eq null}">
                            -
                        </c:if>
                        <c:if test="${not empty b.updateDay}">
                            <fmt:formatDate type="both" value="${b.updateDay}"/>
                        </c:if>
                        <input type="hidden" value="${b.updateDay}" style="width: 200px;border: none;outline: none;" />
                    </td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td><input type="text" value="${b.boardCount}" readonly style="width: 200px;border: none;outline: none;" />
                    </td>
                </tr>
                <tr>
                    <th>작성자<strong style="color: red">*</strong></th>
                    <td><input type="text" name="writer" id="writer" value="${b.writer}" style="width: 200px" required/>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호<strong style="color: red">*</strong></th>
                    <td>
                        <input type="text" name="boardPw" placeholder="비밀번호" id="boardPw" style="width: 200px" required/>
                    </td>
                </tr>

                <tr>
                    <th>제목<strong style="color: red">*</strong></th>
                    <td><input name="title" type="text" value="${b.title}" style="width: 95%" required/></td>
                </tr>
                <tr>
                    <th>내용<strong style="color: red">*</strong></th>
                    <td>
                        <textarea name="content" id="" rows="10" minlength="4" maxlength="2000" style="width: 95%" required>${b.content}</textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <div id="filearea">
                            <input type="file" name="file1" />
                            <input type="file" name="file2"/>
                            <input type="file" name="file3"/>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="btn">
                <input type="button" value="취소" onclick="location.assign('${path}/board/boardDetail.do?boardNo='+${boardNo})"/>
                <input type="submit" value="저장" />
            </div>
        </form>
    </div>
    <script>
        const checkinsert=()=>{
            const writer=$("#writer").val().trim();
            const pw=$("#boardPw").val().trim();
            //작성자 글자 3글자 이상, 5글자 미만
            if(writer.length<3 || writer.length >=5){
                alert("작성자명은 3글자 이상, 5글자 미만으로 입력해야 합니다!");
                return false;
            }
            //비밀번호 4글자 이상, 16글자 미만
            //영문,숫자,특수문자 포함
            const passwordcheck=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()])[A-Za-z\d!@#$%^&*()]{4,16}$/;
            if(!passwordcheck.test(pw)){
                alert("비밀번호는 영문, 숫자, 특수문자를 포함하고 글자 이상, 16글자 미만이어야 합니다.");
                return false;
            }
        }
    </script>
</div>
<jsp:include page="/views/boards/free/common/footer.jsp"/>
