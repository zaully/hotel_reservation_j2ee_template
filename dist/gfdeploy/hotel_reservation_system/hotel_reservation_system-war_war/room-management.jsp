<%@include file="header.jsp" %>
<div class="container">
    <h1 class="title">Room Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation" class="active"><a href="#room_management_tab">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div class="tab-pane active" id="room_management_tab">
                <table class='table wowload fadeInRight'>
                    <tr>
                        <th>Type</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Lowest Quantity</th>
                        <th>Lowest Date</th>
                        <th>Active</th>
                        <th></th>
                        <th></th>
                    </tr>
                    <tr>
                        <td>Economic</td>
                        <td>$199.98</td>
                        <td>100</td>
                        <td>10</td>
                        <td>2015-06-02</td>
                        <td>YES</td>
                        <td><a href="room-type-management.jsp" class='btn-sm'>Modify</td>
                        <td><a href="" class='btn-sm btn-danger'>Delete</td>
                    </tr>
                </table>
                <a href="room-type-management.jsp" class="btn btn-success">Add</a>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>