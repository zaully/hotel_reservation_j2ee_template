<%@include file="header.jsp" %>
<div class="container">
    <h1 class="title">User Portal</h1>
    <div class="row">
        <div class="col-md-8">
            <div class="map"><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2886.9521919590147!2d-79.37787339999998!3d43.64916300000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89d4cb328797459b%3A0x1a28a04b82b66b24!2s1+King+St+E%2C+Toronto%2C+ON+M5C!5e0!3m2!1sen!2sca!4v1428554295680" width="100%" height="420" frameborder="0" style="border:0"></iframe>
            </div>
        </div>
        <div class="login col-md-4">
            <ul class="nav nav-pills">
                <li role="presentation"><a href="#index_register_tab" data-toggle="pill">Register</a></li>
                <li role="presentation" class="active"><a href="#index_login_tab" data-toggle="pill">Login</a></li>
            </ul>
            <div id="index-tab-content" class="tab-content">
                <br />
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
                            <input type="password" class="form-control"  placeholder="Password">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control"  placeholder="Confirm your password">
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" placeholder="Your preference" rows="3"></textarea>
                        </div>
                        <button class="btn btn-default">Submit</button>
                    </form>
                </div>
                <div class="tab-pane active" id="index_login_tab">
                    <form class="wowload fadeInRight">
                        <div class="form-group">
                            <input type="email" class="form-control" placeholder="email" />
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="password" />
                        </div>
                        <button class="btn btn-default">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>