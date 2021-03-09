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
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/chasesstyle.css">
	<title>Welcome</title>
	<style>
		body{
			background-image: url("https://cdn.learfield.com/wp-content/uploads/2017/01/Stacey-West-6365-pyro-sample2.jpg")
		}
	</style>
</head>
<body>
	<h1 class="beach">Welcome to the Smith Site,  <c:out value="${user.firstName}" />!</h1>
	<a class="redbtn" href="/logout">Logout</a>
	<div class="container">
		<h4><iframe src="https://calendar.google.com/calendar/embed?height=600&amp;wkst=1&amp;bgcolor=%23841617&amp;ctz=America%2FChicago&amp;src=ZmRuNTIxMmtlcHFiY3ZldmI4dTA3dW1wOWdAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;color=%23B39DDB&amp;title=Smith%20Events" style="border:solid 1px #777" width="800" height="600" frameborder="0" scrolling="no"></iframe></h4>
		<p class="arrow">Click the <span class="blue" style="height:20px; width:20px">+</span> button to add event to calendar  &#8593 </p>
		<a href="/help" class="yellow">Click here for help with Google Calendar</a>
		<br>
		<h4 class="green">Here are the events in your state (${user.state}):</h4>
		<table class="table table-primary">
			<thead>
				<tr class="orange">
				<th scope="col">Event</th>
				<th scope="col">Date</th>
				<th scope="col">City</th>
				<th scope="col">Host</th>
				<th scope="col">Actions</th>
			</thead>
			<tbody class="border border-primary">
				<c:forEach items="${inState}" var="event">
					<tr>
						<td><a href="events/${event.id}">${event.name}</a></td>
						<td><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${event.date}"/></td>
						<td>${event.city}</td>
						<td>${event.user.firstName}  ${event.user.lastName}</td>
						
						<td><c:if test="${event.user.id == user.id}">
							<a href="events/edit/${event.id}"><button class="yellowbtn">Edit</button></a>
							<form action="/events/${event.id}" method="post" class="d-inline-block">
								<input type="hidden" name="_method" value="delete">
								<input type="hidden" name="userId" value="${user.id}">
								<input type="submit" class="redbtn" value="Delete">
							</form>
						</c:if>
						<c:if test="${event.user.id != user.id}">
			     			<c:set var = "attending" value = "${false}"/>
			     			<c:forEach items="${event.joinedUsers}" var="joinedUser">
			     				<c:if test ="${joinedUser == user}">
			     					<c:set var="attending" value="${true}"/>
			     				</c:if>
			     				
			     			</c:forEach>
			     			<c:choose>
			     				<c:when test="${attending == false}">
			     					<form:form action="/events/join" method="POST" modelAttribute="userEvent">
					      				<input type="hidden" value="${event.id}" name="event">
					      				<input type="hidden" value="${user.id}" name="user">
					      				<button class="bluebtn" type="submit">Join</button>
					      			</form:form>		     					
			     				</c:when>
								<c:otherwise>
									<form:form action="/events/cancel" method="post" class="d-inline block">
										<input type="hidden" name="_method" value="delete">
										<input type="hidden" name="userId" value="${user.id}">
										<input type="hidden" name="eventId" value="${event.id}">
										<input type="submit" class="redbtn"  value="Cancel">
									</form:form>
								</c:otherwise>
							</c:choose>
							</c:if>
						</td>
					</tr>					
				</c:forEach>
			</tbody>			
		</table>
		<br>
		<h4 class="purple">Here are the events outside of (${user.state})</h4>
		<table class="table table-primary">
			<thead>
				<tr class="orange">
				<th scope="col">Event</th>
				<th scope="col">Date</th>
				<th scope="col">City</th>
				<th scope="col">Host</th>
				<th scope="col">Actions</th>
			</thead>
			<tbody class="border border-primary">
				<c:forEach items="${outState}" var="event">
					<tr>
						<td><a href="events/${event.id}">${event.name}</a></td>
						<td><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${event.date}"/></td>
						<td>${event.city}</td>
						<td>${event.user.firstName} ${event.user.lastName}</td>
						<td><c:if test="${event.user.id == user.id}">
							<a href="events/edit/${event.id}"><button class="yellowbtn">Edit</button></a>
							<form action="/events/${event.id}" method="post" class="d-inline-block">
								<input type="hidden" name="_method" value="delete">
								<input type="hidden" name="userId" value="${user.id}">
								<input type="submit" class="redbtn" value="Delete">
							</form>
						</c:if>
						<c:if test="${event.user.id != user.id}">
			     			<c:set var = "attending" value = "${false}"/>
			     			<c:forEach items="${event.joinedUsers}" var="joinedUser">
			     				<c:if test ="${joinedUser == user}">
			     					<c:set var="attending" value="${true}"/>
			     				</c:if>
			     				
			     			</c:forEach>
			     			<c:choose>
			     				<c:when test="${attending == false}">
			     					<form:form action="/events/join" method="POST" modelAttribute="userEvent">
					      				<input type="hidden" value="${event.id}" name="event">
					      				<input type="hidden" value="${user.id}" name="user">
					      				<button class="bluebtn type="submit">Join</button>
					      			</form:form>		     					
			     				</c:when>
								<c:otherwise>
									<form:form action="/events/cancel" method="post" class="d-inline block">
										<input type="hidden" name="_method" value="delete">
										<input type="hidden" name="userId" value="${user.id}">
										<input type="hidden" name="eventId" value="${event.id}">
										<input type="submit" class="redbtn"  value="Cancel">
									</form:form>
								</c:otherwise>
							</c:choose>
							</c:if>
						</td>
					</tr>					
				</c:forEach>
			</tbody>			
		</table>
		<div class="container">
			<h3 class="orange">Create an Event</h3>
			<form:errors path="eventForm.*" class="red"/>
			<form:form action="/events" method="post" modelAttribute="eventForm">
				<p>
					<form:label path="name" class="red">Name:</form:label>
					<form:input placeholder="Event Name?" type="text" path="name"/>
				</p>
				<p>
					<form:label path="date"  class="red">Date:</form:label>
					<form:input type="date" path="date"/>
				</p>
				<p>
					<form:label path="city"  class="red">City:</form:label>
					<form:input placeholder="Where will it be?" type="text" path="city"/>
				</p>
				<p>
        		<form:label path="state" class="red">State:</form:label>
        		<form:select path="state">
        			<form:option value="AL">Alabama (AL)</form:option>
							<form:option value="AK">Alaska (AK)</form:option>
							<form:option value="AZ">Arizona (AZ)</form:option>
							<form:option value="AR">Arkansas (AR)</form:option>
							<form:option value="CA">California (CA)</form:option>
							<form:option value="CO">Colorado (CO)</form:option>
							<form:option value="CT">Connecticut (CT)</form:option>
							<form:option value="DE">Delaware (DE)</form:option>
							<form:option value="DC">District Of Columbia (DC)</form:option>
							<form:option value="FL">Florida (FL)</form:option>
							<form:option value="GA">Georgia (GA)</form:option>
							<form:option value="HI">Hawaii (HI)</form:option>
							<form:option value="ID">Idaho (ID)</form:option>
							<form:option value="IL">Illinois (IL)</form:option>
							<form:option value="IN">Indiana (IN)</form:option>
							<form:option value="IA">Iowa (IA)</form:option>
							<form:option value="KS">Kansas (KS)</form:option>
							<form:option value="KY">Kentucky (KY)</form:option>
							<form:option value="LA">Louisiana (LA)</form:option>
							<form:option value="ME">Maine (ME)</form:option>
							<form:option value="MD">Maryland (MD)</form:option>
							<form:option value="MA">Massachusetts (MA)</form:option>
							<form:option value="MI">Michigan (MI)</form:option>
							<form:option value="MN">Minnesota (MN)</form:option>
							<form:option value="MS">Mississippi (MS)</form:option>
							<form:option value="MO">Missouri (MO)</form:option>
							<form:option value="MT">Montana (MT)</form:option>
							<form:option value="NE">Nebraska (NE)</form:option>
							<form:option value="NV">Nevada (NV)</form:option>
							<form:option value="NH">New Hampshire (NH)</form:option>
							<form:option value="NJ">New Jersey (NJ)</form:option>
							<form:option value="NM">New Mexico (NM)</form:option>
							<form:option value="NY">New York (NY)</form:option>
							<form:option value="NC">North Carolina (NC)</form:option>
							<form:option value="ND">North Dakota (ND)</form:option>
							<form:option value="OH">Ohio (OH)</form:option>
							<form:option value="OK">Oklahoma (OK)</form:option>
							<form:option value="OR">Oregon (OR)</form:option>
							<form:option value="PA">Pennsylvania (PA)</form:option>
							<form:option value="RI">Rhode Island (RI)</form:option>
							<form:option value="SC">South Carolina (SC)</form:option>
							<form:option value="SD">South Dakota (SD)</form:option>
							<form:option value="TN">Tennessee (TN)</form:option>
							<form:option value="TX">Texas (TX)</form:option>
							<form:option value="UT">Utah (UT)</form:option>
							<form:option value="VT">Vermont(VT)</form:option>
							<form:option value="VA">Virginia(VA)</form:option>
							<form:option value="WA">Washington(WA)</form:option>
							<form:option value="WV">West Virginia(WV)</form:option>
							<form:option value="WI">Wisconsin(WI)</form:option>
							<form:option value="WY">Wyoming(WY)</form:option>
				</form:select>
        		</p>
        <button type="submit" class="greenbtn">Create Event</button>
        </form:form>
		</div>
	</div>
</body>
</html>