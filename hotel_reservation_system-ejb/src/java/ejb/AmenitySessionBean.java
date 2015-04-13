/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author vince
 */
@Stateless
public class AmenitySessionBean implements AmenitySessionBeanRemote, AmenitySessionBeanLocal {

    @PersistenceContext(unitName = "hotel_reservation_system-ejbPU")
    private EntityManager em;
    
    @Override
    public List getAllAmenities(int count, int skip) {
        if (count <= 0) {
            count = 20;
        }
        if (skip < 0) {
            skip = 0;
        }
        List amenities = em.createNamedQuery("Amenity.findAll").setMaxResults(count).setFirstResult(skip).getResultList();
        return amenities;
    }

    @Override
    public int getTotalCount() {
        int count = ((Long)em.createNamedQuery("Amenity.countAmenities").getSingleResult()).intValue();
        return count;
    }

    @Override
    public Object getAmenityByAID(int aid) {
        try {
            Object amenity = em.find(Amenity.class, aid);
            return amenity;
        } catch (Exception e) {
            
        }
        return null;
    }

    @Override
    public Boolean createAmenity(Object amenity) {
        em.persist(amenity);
        em.flush();
        if(((Amenity)amenity).getAmenityId() > 0) {
            return true;
        }
        return false;
    }

    @Override
    public Boolean saveChange(Object amenity) {
        try {
            em.merge(amenity);
            em.flush();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void deleteAmenity(int aid) {
        try {
            Object amenity = em.find(Amenity.class, aid);
            em.remove(amenity);
            em.flush();
        } catch (Exception e) {
        }
    }
}
