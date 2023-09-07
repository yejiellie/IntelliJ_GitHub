<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.study.dao.CategoryDao" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.vo.Category" %>
<%@ include file="common/header.jsp" %>
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
    .pl {
        width: 208px;
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
<%
    CategoryDao cdao=new CategoryDao();
    List<Category> clist=cdao.selectAll(); //전체 카테고리 호출

    BoardDao dao=new BoardDao();
    List<Board> list=dao.searchAll();  //전체 게시글 호출

%>

<div style="padding: 20px">
    <h2 style="padding-bottom: 20px">게시판 - 등록</h2>
    <div id="board-container">
        <form name="enrollBoard" action="<%=request.getContextPath()%>/views/boards/free/enrollboard.jsp"
              method="post" onsubmit="return checkinsert();" enctype="multipart/form-data">
                                <%--아이디 비번 확인 용도--%>
            <table id="tbl-board">
                <tr>
                    <th>카테고리<strong style="color: red">*</strong></th>
                    <td>
                        <select name="category" id="cate"  class="pl">
                            <option selected disabled>카테고리 선택</option>
                            <% if(!clist.isEmpty()){
                                for(Category c : clist){
                            %>
                            <option value="<%=c.getCateNo()%>"><%=c.getCateName()%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>작성자<strong style="color: red">*</strong></th>
                    <td><input type="text" name="writer" id="writer" style="width: 200px" required/>
                        <div>
                            <span id="lengthCheck"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호<strong style="color: red">*</strong></th>
                    <td>
                        <input type="text" name="boardpw" placeholder="비밀번호" id="boardpw" style="width: 200px" required/>
                        <input type="text" placeholder="비밀번호 확인" id="boardrwcheck" style="width: 200px"/>
                        <div style="width: 300px" >
                            <span id="pwresult"></span>
                        </div>
                    </td>
                </tr>
                <script>
                    //작성자 글자 3글자 이상, 5글자 미만
                    // $(()=>{
                    //     const writer = $("#writer").val();
                    //     if (writer.trim().length < 3 || writer.trim().length>=5) {
                    //         $("#lengthCheck").css("color","red").text("작성자명은 3글자 이상, 5글자 미만으로 입력해야 합니다!");
                    //         $("#writer").val('');
                    //         $("#writer").focus();
                    //     }else{
                    //         $("#lengthCheck").text("");
                    //     }
                    // });

                    //비밀번호 중복확인
                    $(()=>{
                        $("#boardrwcheck").blur(e=>{
                            const pw=$("#boardpw").val();
                            const pwck=$(e.target).val();
                            if(pw!=null){
                                if(pw==pwck){
                                    $("#pwresult").css("color","green").text("비밀번호가 일치합니다.");
                                }else{
                                    $("#pwresult").css("color","red").text("비밀번호가 일치하지 않습니다.");
                                }
                            }
                        });
                    });
                </script>

                <tr>
                    <th>제목<strong style="color: red">*</strong></th>
                    <td><input name="title" type="text" style="width: 95%" required/></td>
                </tr>
                <tr>
                    <th>내용<strong style="color: red">*</strong></th>
                    <td>
                        <textarea name="content" id="" rows="10" style="width: 95%" required></textarea>
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
                <input type="button" value="취소" onclick="location.assign('<%=request.getContextPath()%>/views/boards/free/list.jsp')"/>
                <input type="submit" value="저장" />
            </div>
        </form>
    </div>
    <script>
        const checkinsert=()=>{
            const writer=$("#writer").val().trim();
            const pw=$("#boardpw").val().trim();
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
<%@ include file="common/footer.jsp" %>