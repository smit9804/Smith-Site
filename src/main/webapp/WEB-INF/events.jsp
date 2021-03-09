<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="css/chasesstyle.css">
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<title>Event Info</title>
</head>
<body>
	<div class="container text-right ">
		<div class="mt-3 pr-2">
			<a href="/events"><button class="btn btn-success shadow">Home</button></a>
			<a href="/logout"><button class="btn btn-danger">Logout</button></a>
			
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col">
				<h1 class="display-4 border-bottom border-info d-inline-block ">${event.name}</h1>
				<div class="mt-4 ">
					<h5>Host: ${event.user.firstName}</h5>
					<h5>Date: <fmt:formatDate type = "date" dateStyle = "long" timeStyle = "long" value = "${event.date}" /></h5>
					<h5>Location: ${event.city}, ${event.state}</h5>
					
				</div>
			</div>
		</div>
	</div>
	<div class="orange">
		<h4>Current site users attending:</h4>
		<table class="table table-warning table-striped">
			<thead>
			<tr>
				<th scope="col" class="orange">Name</th>
				<th scope="col" class="yellow">From</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach items="${event.joinedUsers}" var="i">
					<tr>
						<td>${i.firstName} ${i.lastName}</td>
						<td>${i.city}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="h-75 border border-info" style="overflow: scroll;">
					<c:forEach items="${event.comments}" var="comment">
						<p class="text-success" >${comment.user.firstName}:  ${comment.comment} </p>
					</c:forEach>
				</div>
				<br>
				<form:form action="/events/${event.id}" method="POST" modelAttribute="addComment">
					<form:input path="comment" cssClass="form-control bg-danger text-white" placeholder="Comment..."/>
					<p><form:errors path="comment"/></p>
					<br>
					<div class="text-right">
						<Button type="submit" class="btn btn-outline-info ">Add Comment</Button>
					</div>
				</form:form>
</body>
</html>