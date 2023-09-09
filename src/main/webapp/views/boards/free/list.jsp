<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.study.dao.BoardDao" %>
<%@ page import="com.study.dao.CategoryDao" %>
<%@ page import="com.study.vo.Board" %>
<%@ page import="com.study.vo.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="common/header.jsp" %>
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
<%
    CategoryDao cdao=new CategoryDao();
    List<Category> clist=cdao.selectAll(); //전체 카테고리 호출

    BoardDao dao=new BoardDao();
//    List<Board> list=dao.searchAll();  //전체 게시글 호출

    //페이지바 구현하기
    int cPage;              //현재 사용자가 보고있는 페이지
    int numPerpage=5;       //페이지당 출력될 데이터의 갯수

    try {
        cPage=Integer.parseInt(request.getParameter("cPage"));
    }catch(NumberFormatException e) {
        cPage=1;
    }

    List<Board> list=dao.searchAll(cPage,numPerpage);

    int totalData=dao.selectBoardCount();
    String pageBar="";
    int pageBarSize=5;
    //전체 페이지 수
    int totalPage=(int)Math.ceil((double)totalData/numPerpage);

    int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
    int pageEnd=pageNo+pageBarSize-1;

    if(pageNo==1) {
        pageBar+="<span>[이전]</span>";
    }else {
        pageBar+="<a href='"+request.getContextPath()
                +"/views/boards/free/list.jsp?cPage="+(pageNo-1)+"'> [이전] </a>";
    }
    while(!(pageNo>pageEnd||pageNo>totalPage)) {
        if(cPage==pageNo) {
            pageBar+="<span>"+pageNo+"</span>";
        }else {
            pageBar+="<a href='"+request.getContextPath()
                    +"/views/boards/free/list.jsp?cPage="+pageNo+"'>"+" "+pageNo+" "+"</a>";
        }
        pageNo++;
    }

    if(pageNo>totalPage) {
        pageBar+="<span>[다음]</span>";
    }else {
        pageBar+="<a href='"+request.getContextPath()
                +"/views/boards/free/list.jsp?cPage="+pageNo+"'> [다음] </a>";
    }

%>


<div style="padding: 20px;">
<h2 style="padding-bottom: 20px">자유 게시판 - 목록</h2>
<form action="" method="get">
    <div id="searchdata">
        등록일 <input type="date" id="beforeDate" />~<input type="date" id="currentDate"/>
        <div id="totalsearch">
            <select name="likeLanguage" id="" class="pl">
                <option selected disabled>카테고리 선택</option>
                <%--카테고리 전체 내용을 출력 --%>
                <% if(!clist.isEmpty()){
                    for(Category c : clist){
                %>
                <option value="<%=c.getCateNo()%>"><%=c.getCateName()%></option>
                <%
                        }
                    }
                %>
            </select>
            <input type="text" id="searchbox" placeholder="검색어를 입력해주세요.(제목+작성자+내용)"/>
            <input type="submit" id="btn-search" value="검색" />
        </div>
    </div>
</form>

    <script>
        //현재 날짜 디폴트값
        document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);
        var now = new Date();
        //1년전
        document.getElementById('beforeDate').value = new Date(now.setFullYear(now.getFullYear() - 1)).toISOString().substring(0, 10);
    </script>

    <p>총 <%=list.size()%>건</p>

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
        <%
            if(!list.isEmpty()) {
                for(Board b : list){
                    //날짜 형식을 바꿔줌
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd HH:mm");
                    String createday=formatter.format(b.getCreateDay());
                    String updateday="-";
                    if(b.getUpdateDay()!=null){
                        updateday=formatter.format(b.getUpdateDay());
                    }
                    String title="";
                    //제목이 80자가 넘는경우 ...으로 대체지만 너무 길어서 30자로 대체
                    if(b.getTitle().length()>=30) {
                        title = b.getTitle().substring(0, 30).concat("...");
//                        System.out.println(title);
                    }
        %>
        <tr id="tableinfo">
            <td>
            <% if(!clist.isEmpty()){
                for(Category c : clist){
            %>
            <%=b.getCateNo()==c.getCateNo()?c.getCateName():""%>
            <%
                    }
                }
            %>
            </td>
            <td><%=b.getFile()!=null?"📎":""%></td>
            <td><a href="<%=request.getContextPath()%>/views/boards/free/view.jsp?boardNo=<%=b.getBoardNo()%>"><%=title==""?b.getTitle():title%></a></td>
            <td><%=b.getWriter()%></td>
            <td><%=b.getBoardCount()%></td>
            <td><%=createday%></td>
            <td><%=b.getUpdateDay()!=null?updateday:"-"%></td>
        </tr>
        <%
                }
            }
        %>
    </table>

    <div id="pageBar"><%=pageBar%></div>
    <div style="float: right; padding: 50px">
        <input type="button" onclick="insertbaord();" value="등록" style="width: 90px" />
    </div>
    <script>
        const insertbaord=()=>{
            location.href="<%=request.getContextPath()%>/views/boards/free/write.jsp";
        }
    </script>
</section>
</div>
<%@ include file="common/footer.jsp" %>