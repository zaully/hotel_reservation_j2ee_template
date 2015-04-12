/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author vince
 */
@Entity
@Table(name = "room_type")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RoomType.findAll", query = "SELECT r FROM RoomType r"),
    @NamedQuery(name = "RoomType.findByRoomTypeId", query = "SELECT r FROM RoomType r WHERE r.roomTypeId = :roomTypeId"),
    @NamedQuery(name = "RoomType.findByRoomTypeName", query = "SELECT r FROM RoomType r WHERE r.roomTypeName = :roomTypeName"),
    @NamedQuery(name = "RoomType.findByRoomSize", query = "SELECT r FROM RoomType r WHERE r.roomSize = :roomSize"),
    @NamedQuery(name = "RoomType.findByRoomPrice", query = "SELECT r FROM RoomType r WHERE r.roomPrice = :roomPrice"),
    @NamedQuery(name = "RoomType.findByActivated", query = "SELECT r FROM RoomType r WHERE r.activated = :activated")})
public class RoomType implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "room_type_id")
    private Integer roomTypeId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "room_type_name")
    private String roomTypeName;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Column(name = "room_size")
    private BigDecimal roomSize;
    @Basic(optional = false)
    @NotNull
    @Column(name = "room_price")
    private BigDecimal roomPrice;
    @Basic(optional = false)
    @NotNull
    @Column(name = "activated")
    private boolean activated;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "room_description")
    private String roomDescription;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "roomTypeId")
    private Collection<Reservation> reservationCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "roomTypeId")
    private Collection<RoomAmenity> roomAmenityCollection;

    public RoomType() {
    }

    public RoomType(Integer roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public RoomType(Integer roomTypeId, String roomTypeName, BigDecimal roomSize, BigDecimal roomPrice, boolean activated, String roomDescription) {
        this.roomTypeId = roomTypeId;
        this.roomTypeName = roomTypeName;
        this.roomSize = roomSize;
        this.roomPrice = roomPrice;
        this.activated = activated;
        this.roomDescription = roomDescription;
    }

    public Integer getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(Integer roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getRoomTypeName() {
        return roomTypeName;
    }

    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    public BigDecimal getRoomSize() {
        return roomSize;
    }

    public void setRoomSize(BigDecimal roomSize) {
        this.roomSize = roomSize;
    }

    public BigDecimal getRoomPrice() {
        return roomPrice;
    }

    public void setRoomPrice(BigDecimal roomPrice) {
        this.roomPrice = roomPrice;
    }

    public boolean getActivated() {
        return activated;
    }

    public void setActivated(boolean activated) {
        this.activated = activated;
    }

    public String getRoomDescription() {
        return roomDescription;
    }

    public void setRoomDescription(String roomDescription) {
        this.roomDescription = roomDescription;
    }

    @XmlTransient
    public Collection<Reservation> getReservationCollection() {
        return reservationCollection;
    }

    public void setReservationCollection(Collection<Reservation> reservationCollection) {
        this.reservationCollection = reservationCollection;
    }

    @XmlTransient
    public Collection<RoomAmenity> getRoomAmenityCollection() {
        return roomAmenityCollection;
    }

    public void setRoomAmenityCollection(Collection<RoomAmenity> roomAmenityCollection) {
        this.roomAmenityCollection = roomAmenityCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (roomTypeId != null ? roomTypeId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RoomType)) {
            return false;
        }
        RoomType other = (RoomType) object;
        if ((this.roomTypeId == null && other.roomTypeId != null) || (this.roomTypeId != null && !this.roomTypeId.equals(other.roomTypeId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ejb.RoomType[ roomTypeId=" + roomTypeId + " ]";
    }
    
}
