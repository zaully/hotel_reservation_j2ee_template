/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author vince
 */
@Entity
@Table(name = "room_amenity")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RoomAmenity.findAll", query = "SELECT r FROM RoomAmenity r"),
    @NamedQuery(name = "RoomAmenity.findByRoomAmenityId", query = "SELECT r FROM RoomAmenity r WHERE r.roomAmenityId = :roomAmenityId"),
    @NamedQuery(name = "RoomAmenity.removeByRoomTypeId", query = "delete from RoomAmenity r WHERE r.roomTypeId = :roomTypeId"),
    @NamedQuery(name = "RoomAmenity.findByAmenityId", query = "SELECT r FROM RoomAmenity r WHERE r.amenityId = :amenityId"),
    @NamedQuery(name = "RoomAmenity.findByRoomTypeId", query = "SELECT r FROM RoomAmenity r WHERE r.roomTypeId = :roomTypeId")})
public class RoomAmenity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "room_amenity_id")
    private Integer roomAmenityId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "amenity_id")
    private int amenityId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "room_type_id")
    private int roomTypeId;

    public RoomAmenity() {
    }

    public RoomAmenity(Integer roomAmenityId) {
        this.roomAmenityId = roomAmenityId;
    }

    public RoomAmenity(Integer roomAmenityId, int amenityId, int roomTypeId) {
        this.roomAmenityId = roomAmenityId;
        this.amenityId = amenityId;
        this.roomTypeId = roomTypeId;
    }

    public Integer getRoomAmenityId() {
        return roomAmenityId;
    }

    public void setRoomAmenityId(Integer roomAmenityId) {
        this.roomAmenityId = roomAmenityId;
    }

    public int getAmenityId() {
        return amenityId;
    }

    public void setAmenityId(int amenityId) {
        this.amenityId = amenityId;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (roomAmenityId != null ? roomAmenityId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RoomAmenity)) {
            return false;
        }
        RoomAmenity other = (RoomAmenity) object;
        if ((this.roomAmenityId == null && other.roomAmenityId != null) || (this.roomAmenityId != null && !this.roomAmenityId.equals(other.roomAmenityId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ejb.RoomAmenity[ roomAmenityId=" + roomAmenityId + " ]";
    }
    
}
