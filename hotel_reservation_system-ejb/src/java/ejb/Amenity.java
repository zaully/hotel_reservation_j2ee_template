/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.io.Serializable;
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
@Table(name = "amenity")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Amenity.findAll", query = "SELECT a FROM Amenity a"),
    @NamedQuery(name = "Amenity.findByAmenityId", query = "SELECT a FROM Amenity a WHERE a.amenityId = :amenityId"),
    @NamedQuery(name = "Amenity.findByAmenityName", query = "SELECT a FROM Amenity a WHERE a.amenityName = :amenityName")})
public class Amenity implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "amenity_id")
    private Integer amenityId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "amenity_name")
    private String amenityName;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 65535)
    @Column(name = "amenity_description")
    private String amenityDescription;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "amenityId")
    private Collection<RoomAmenity> roomAmenityCollection;

    public Amenity() {
    }

    public Amenity(Integer amenityId) {
        this.amenityId = amenityId;
    }

    public Amenity(Integer amenityId, String amenityName, String amenityDescription) {
        this.amenityId = amenityId;
        this.amenityName = amenityName;
        this.amenityDescription = amenityDescription;
    }

    public Integer getAmenityId() {
        return amenityId;
    }

    public void setAmenityId(Integer amenityId) {
        this.amenityId = amenityId;
    }

    public String getAmenityName() {
        return amenityName;
    }

    public void setAmenityName(String amenityName) {
        this.amenityName = amenityName;
    }

    public String getAmenityDescription() {
        return amenityDescription;
    }

    public void setAmenityDescription(String amenityDescription) {
        this.amenityDescription = amenityDescription;
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
        hash += (amenityId != null ? amenityId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Amenity)) {
            return false;
        }
        Amenity other = (Amenity) object;
        if ((this.amenityId == null && other.amenityId != null) || (this.amenityId != null && !this.amenityId.equals(other.amenityId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ejb.Amenity[ amenityId=" + amenityId + " ]";
    }
    
}
