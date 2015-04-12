<%@include file="header.jsp" %>
<div class="container">
    <h1 class="title">User Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation" class="active"><a href="#user_management_tab">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane active" id="user_management_tab">
                    <table class='table wowload fadeInRight'>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Member since</th>
                            <th>Last visit</th>
                            <th>Visits</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr>
                            <td>Vince</td>
                            <td>vince@vince.com</td>
                            <td>123-456-7890</td>
                            <td>2015-05-01</td>
                            <td>2015-05-02</td>
                            <td>1</td>
                            <td><a href="book-room.jsp" class='btn-sm'>Check Details</td>
                            <td><a href="" class='btn-sm btn-danger'>Delete</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>