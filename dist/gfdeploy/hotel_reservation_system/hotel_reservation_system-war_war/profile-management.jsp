<%@include file="header.jsp" %>
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
                <div class="tab-pane active" id="profile_tab">
                    <form role="form" class="wowload fadeInRight">
                        <div class="form-group">
                            <input type="email" class="form-control"  placeholder="Email (will be your username)">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control"  placeholder="Name">
                        </div>
                        <div class="form-group">
                            <input type="Phone" class="form-control"  placeholder="Phone">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control"  placeholder="Password (Leave blank if you don't want to change it)">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control"  placeholder="Confirm your password">
                        </div>
                        <button class="btn btn-default">Modify</button>
                    </form>
                </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>