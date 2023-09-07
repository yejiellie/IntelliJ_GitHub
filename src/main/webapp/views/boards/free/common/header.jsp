<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<style>
    body{
        font-family:"휴먼모음T";
    }

    div,section,header,footer{padding:10px;}

    div#container{
        background-color:#F0F0F0;
        width:100%;
        margin:0 auto;
    }

    header{
        background-color: rgba(79, 197, 115, 0.95);
        height:130px;
        position:relative;
        padding:10px 0 0 0;
    }
    header h1{
        margin-left : 10px;
    }

    section#content{
        background-color:#F5F5F5;
        float:left;
        width:100%;
        min-height:500px;
    }

    footer{
        background-color: rgba(79, 197, 115, 0.95);
        clear:both;
        height:75px;
        text-align:center;
        padding-top:40px;
    }
    header nav {background: #1d6403; width:100%; margin-top:40px;}
    ul.main-nav{
        /*width:80%;*/
        display:table;
        padding:0px;
        margin:auto;
    }
    ul.main-nav li {
        list-style-type: none;
        width: 8em;
        height: 2em;
        float: left;
        text-align: center;
        font-family: "휴먼모음T", sans-serif;
        border-left: 1px #3cd400 solid;
        background-color: #1d6403;
    }
    ul.main-nav li:last-of-type{border-right:1px rgba(0, 255, 85, 0.95) solid;;}
    ul.main-nav li a {
        display: block;
        padding:.5em;
        text-decoration: none;
        color: #292929;
    }
    ul.main-nav li:hover{
        background-color: #1d6403;
    }
    ul.main-nav li:hover > a{
        color:#FFF; /* 글자색*/
    }
</style>
<head>
    <title>JSP - Hello World</title>
</head>

<div id="container">
    <header>
        <h1><a href="<%=request.getContextPath()%>" style="text-decoration:none; color:black;">Hello Servlet</a></h1>
        <nav>
            <ul class="main-nav">
                <li class="home"><a href="<%=request.getContextPath()%>" style="text-decoration:none; color:black;">home</a></li>
                <li id="board"><a href="<%=request.getContextPath()%>/WEB-INF/views/boards/free/list.jsp">게시판</a></li>
                <li id="test"><a href="#">준비중입니다.</a></li>
            </ul>
        </nav>
    </header>
</div>
