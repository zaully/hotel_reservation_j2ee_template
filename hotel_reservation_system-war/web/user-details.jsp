<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    try {
        int uid = Integer.parseInt(request.getParameter("uid"));
        User u = (User)ub.getUserByUID(uid);
        if (u != null) {
            %>
<div class="container">
    <h1 class="title">Profile and Settings</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation" class="active"><a href="#index_user_profile_tab">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane active" id="index_user_profile_tab">
                    <form role="form" class="wowload fadeInRight">
                        <div class="form-group">
                            <input type="email" class="form-control" readonly value='<%= u.getEmail() %>'>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" readonly value='<%= u.getName() %>'>
                        </div>
                        <div class="form-group">
                            <input type="Phone" class="form-control" readonly value='<%= u.getPhone() %>'>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" readonly rows="5"><%= u.getPreference()%></textarea>
                        </div>
                        <a href='user-management.jsp' class="btn btn-default">Back</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>      
            <%
        }
    } catch (Exception e) {
        %> <jsp:forward page="index.jsp" /> <%
    }
%>
<%@include file="footer.jsp" %>