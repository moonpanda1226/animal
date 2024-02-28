package org.sh.dao;

import java.util.List;

import org.sh.dto.GalleryDTO;
import org.springframework.stereotype.Repository;

@Repository
public class GalleryDAO extends AbstractDAO{
	
	public int galleryInsert(GalleryDTO dto ) {
		return sqlSession.insert("gallery.galleryInsert", dto);
	}

	public List<GalleryDTO> galleryList() {
		return sqlSession.selectList("gallery.galleryList");
	}

	public GalleryDTO galleryDetail(int no) {
		return sqlSession.selectOne("gallery.galleryDetail", no);
	}
}
