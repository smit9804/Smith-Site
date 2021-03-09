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
    <!-- <style>
    	body{
    		background-image: linear-gradient(#0078d7, rgb(248, 226, 199));
    	}
    </style> -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<title>Event Info</title>
</head>
<body>


<form:form action="/events/${event.id}" method="POST" modelAttribute="event" >
	<input type="hidden" name="_method" value="put">
	<p>
		<form:label path="name" cssClass="h5 font-weight-normal">Event Name</form:label>
		<form:input path="name" cssClass="form-control  col-7 text-primary"/>
	</p>
	<p>
		<form:label path="date" cssClass="h5 font-weight-normal">Date</form:label>
		<form:input path="date" type="date" cssClass="form-control  col-7 text-primary"/>
	</p>
	<p>
		<form:label path="city" cssClass="h5 font-weight-normal">City</form:label>
		<form:input path="city" cssClass="form-control  col-7 text-primary"/>
	</p>
	<p>
		<form:label path="state" cssClass="h5 font-weight-normal d-block">State</form:label>
		<form:select cssClass="custom-select col-7  text-primary" path="state">
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
	<br>
		<div class="text-center pr-5">
			<input class="greenbtn" type="submit" value="Update Event"/>
		</div>
	</form:form>
</body>
</html>
					