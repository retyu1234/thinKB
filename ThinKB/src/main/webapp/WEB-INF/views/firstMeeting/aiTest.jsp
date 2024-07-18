<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenAI Integration</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>Ask OpenAI</h1>
    <form id="openaiForm" action="process" method="post">
        <label for="question">질문:</label>
        <input type="text" id="question" name="question" required>
        <input type="submit" value="전송">
    </form>

    <h2>답변:</h2>
    <textarea id="response" rows="10" cols="50"></textarea>

    <script>
        $(document).ready(function(){
            $('#openaiForm').submit(function(event){
                event.preventDefault();
                $.ajax({
                    url: 'process',
                    type: 'POST',
                    data: $(this).serialize(),
                    success: function(response){
                        $('#response').text(response);
                    }
                });
            });
        });
    </script>
</body>
</html>
