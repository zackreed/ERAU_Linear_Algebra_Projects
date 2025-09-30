function show_square_faces_from_vectors(face_vectors)    
    %show the faces
    for i=1:size(face_vectors,1)
        vector=face_vectors(i,:);
        vector_size=sqrt(length(vector));
        scale_ratio=floor(256/vector_size);
        face=reshape(vector,vector_size,vector_size);
        linalg.show_img(face,scale_ratio);
        pause(.1)
    end
end