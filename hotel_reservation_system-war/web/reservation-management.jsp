<%@include file="header.jsp" %>
<div class="container">
    <h1 class="title">Reservation Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation" class="active"><a href="#reservation_management_tab">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane active" id="reservation_management_tab">
                    <table class='table wowload fadeInRight'>
                        <tr>
                            <th>Client</th>
                            <th>Starting from</th>
                            <th>Ends at</th>
                            <th>Room type</th>
                            <th>Rooms</th>
                            <th>Overall Price</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr>
                            <td>Vince</td>
                            <td>2015-05-01</td>
                            <td>2015-05-02</td>
                            <td>Economic</td>
                            <td>1</td>
                            <td>$199.98</td>
                            <td><a href="book-room.jsp" class='btn-sm'>Modify</td>
                            <td><a href="" class='btn-sm btn-danger'>Cancel</td>
                        </tr>
                    </table>
                    <a href="book-room.jsp" class="btn btn-success">Add</a>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>