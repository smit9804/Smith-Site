<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Registration</title>
     <link rel="stylesheet" type="text/css" href="css/chasesstyle.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
</head>
<body>
    <h1>Register!</h1>
    
    <p><form:errors path="user.*"/></p>
    
    <form:form method="POST" action="/registration" modelAttribute="user">
        <p>
            <form:label path="firstName">First Name:</form:label>
            <form:input type="text" path="firstName"/>
        </p>
        <p>
            <form:label path="lastName">Last Name:</form:label>
            <form:input type="text" path="lastName"/>
        </p>
        <p>
			<form:label path="city">Location:</form:label>
			<form:input type="text" path="city"/>        
        </p>
        <p>
        	<form:label path="state">State:</form:label>
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
        <p>
            <form:label path="email">Email:</form:label>
            <form:input type="email" path="email"/>
        </p>
        <p>
            <form:label path="password">Password:</form:label>
            <form:password path="password"/>
        </p>
        <p>
            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
            <form:password path="passwordConfirmation"/>
        </p>
        <input class="greenbtn" type="submit" value="Register!"/>
    </form:form>
    
    <h1>Login</h1>
    <p><c:out value="${error}" /></p>
    <form method="post" action="/login">
        <p>
            <label for="email">Email</label>
            <input type="text" id="email" name="email"/>
        </p>
        <p>
            <label for="password">Password</label>
            <input type="password" id="password" name="password"/>
        </p>
        <input class="bluebtn" type="submit" value="Login!"/>
    </form>  
    
</body>
</html>