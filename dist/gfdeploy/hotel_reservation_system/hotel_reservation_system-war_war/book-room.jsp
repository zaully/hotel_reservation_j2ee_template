<%@include file="header.jsp" %>

<div class="container">
<h2>Room Reservation</h2>
    <!-- reservation-information -->
    <div id="information" class="spacer-sm reserve-info ">
        <div class="container">
            <div class="row">
                <div class="col-sm-7 col-md-8">
                    <div id="RoomDetails" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                        <div class="item active"><img src="images/photos/8.jpg" class="img-responsive" alt="slide"></div>
                        <div class="item  height-full"><img src="images/photos/9.jpg"  class="img-responsive" alt="slide"></div>
                        <div class="item  height-full"><img src="images/photos/10.jpg"  class="img-responsive" alt="slide"></div>
                        </div>
                        <!-- Controls -->
                        <a class="left carousel-control" href="#RoomDetails" role="button" data-slide="prev"><i class="fa fa-angle-left"></i></a>
                        <a class="right carousel-control" href="#RoomDetails" role="button" data-slide="next"><i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <div class="col-sm-5 col-md-4">
                    <div id="index-tab-content" class="tab-content">
                        <br />
                        <div class="tab-pane active" id="book_info_form">
                            <%@include file="book-form.jsp" %>
                        </div>
                    </div>
                </div>
            </div>  
        </div>
    </div>
    <!-- reservation-information -->
</div>
<%@include file="footer.jsp" %>