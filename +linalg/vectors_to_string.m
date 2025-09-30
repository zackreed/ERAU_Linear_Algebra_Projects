function output_string=vectors_to_string(matrix)

    alphabet = [" ", "A", "B", "C", "D", "E", ...
                "F", "G", "H", "I", "J", "K", ...
                "L", "M", "N", "O", "P", ...
                "Q", "R", "S", "T", "U", "V", ...
                "W", "X", "Y", "Z", ",", "."];

    encrypted_vect=mod(matrix,29);
    encrypted_idx=encrypted_vect(:)+1;
    encryption="";
    for i=1:length(encrypted_idx)
        mapped=encrypted_idx(i);
        encryption=encryption+alphabet(mapped);
    end
    output_string=encryption;
end