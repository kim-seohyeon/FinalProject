<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자료 등록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            margin: 50px auto;
            background: #ffffff;
            border-radius: none;
            padding: 30px 40px;
            box-shadow: none;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 28px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 12px 10px;
            color: #34495e;
            width: 20%;
            vertical-align: top;
        }

        td {
            padding: 12px 10px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
        }

        input[type="file"] {
            font-size: 14px;
            padding: 5px 0;
        }

        .error {
            color: #e74c3c;
            font-size: 13px;
            margin-top: 5px;
            display: block;
        }

        .submit-row {
            text-align: center;
            padding-top: 20px;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<jsp:include page="/views/header.jsp" />

<div class="container">
    <h1>자료 등록</h1>
    
    <form:form action="libWrite" method="post" modelAttribute="libraryCommand" enctype="multipart/form-data">
        <table>
            <tr>
                <th>제목</th>
                <td>
                    <form:input path="libSubject" />
                    <form:errors path="libSubject" cssClass="error"/>
                </td>
            </tr>
            <tr>
                <th>글쓴이</th>
                <td>
                    <form:input path="libWriter" />
                    <form:errors path="libWriter" cssClass="error"/>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <form:textarea path="libContent" rows="5" />
                    <form:errors path="libContent" cssClass="error"/>
                </td>
            </tr>
            <tr>
                <th>파일</th>
                <td><input type="file" name="libFile" multiple="multiple" /></td>
            </tr>
            <tr>
                <th>이미지파일</th>
                <td><input type="file" name="libImageFile" /></td>
            </tr>
        </table>

        <div class="submit-row">
            <input type="submit" value="자료 등록 완료" />
        </div>
    </form:form>
</div>

<jsp:include page="/views/footer.jsp" />
</body>
</html>
