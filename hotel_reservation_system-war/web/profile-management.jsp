<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    if (request.getMethod().compareToIgnoreCase("post") == 0) {
        user.setName(request.getParameter("name"));
        user.setPhone(request.getParameter("phone"));
        if (request.getParameter("password") != null && request.getParameter("password").length() > 6) {
            user.setPassword(request.getParameter("password"));
        }
    }
%>
<div class="container">
    <h1 class="title">Profile and Settings</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" class="active"><a href="#profile_tab">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <% 
                if(request.getMethod().compareToIgnoreCase("post") == 0) { 
                    if (ub.saveChange(user)) {
            %>
            <div class="alert alert-success" role="alert">
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Success:</span>Saving change succeeded
            </div>
            <% } else { %>
            <div class="alert alert-danger" role="alert">
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Error:</span>Saving change failed
            </div>
            <% } } %>
            <div class="tab-pane active" id="profile_tab">
                <form action="profile-management.jsp" method="POST" role="form" class="wowload fadeInRight">
                    <div class="form-group">
                        <input name="email" type="email" class="form-control"  placeholder="Email (will be your username)" readonly value="<%= user.getEmail() %>">
                    </div>
                    <div class="form-group">
                        <input name="name" type="text" class="form-control"  placeholder="Name" value="<%= user.getName() %>">
                    </div>
                    <div class="form-group">
                        <input name="phone" type="Phone" class="form-control"  placeholder="Phone" value="<%= user.getPhone() %>">
                    </div>
                    <div class="form-group">
                        <input name="password" type="password" class="form-control"  placeholder="Password (Leave blank if you don't want to change it)">
                    </div>
                    <div class="form-group">
                        <input name="password-confirm" type="password" class="form-control"  placeholder="Confirm your password">
                    </div>
                    <input type="submit" value="Modify" name="modify" class="btn btn-default"/>
                </form>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>