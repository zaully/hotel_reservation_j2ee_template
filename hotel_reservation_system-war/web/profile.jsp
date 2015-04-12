<%@include file="header.jsp" %>
<div class="container">
    <h1 class="title">Profile and Settings</h1>
    <div class="row">
        <div class="login col-md-2">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="#index_register_tab" data-toggle="pill">Profile</a></li>
                <li role="presentation" class="active"><a href="#index_login_tab" data-toggle="pill">Reservation</a></li>
            </ul>
        </div>
        <div class="login col-md-10">
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane" id="index_register_tab">
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
                        <div class="form-group">
                            <textarea class="form-control" placeholder="Your preference" rows="5"></textarea>
                        </div>
                        <button class="btn btn-default">Modify</button>
                    </form>
                </div>
                <div class="tab-pane active" id="index_login_tab">
                    <table class='table'>
                        <tr>
                            <th>Starting from</th>
                            <th>Ends at</th>
                            <th>Room type</th>
                            <th>Rooms</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr>
                            <td>2015-05-01</td>
                            <td>2015-05-02</td>
                            <td>Economic</td>
                            <td>1</td>
                            <td><a href="book-room.jsp" class='btn-sm'>Modify</td>
                            <td><a href="" class='btn-sm btn-danger'>Cancel</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>