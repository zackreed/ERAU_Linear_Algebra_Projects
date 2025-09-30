function indices = string_to_vector(input_string)
    % STRING_TO_VECTOR Converts a string into its corresponding indices
    % based on a predefined alphabet, and returns a column vector.
    %
    %   indices = string_to_vector(input_string)
    %
    %   INPUT:
    %       input_string - A string to be converted to indices
    %
    %   OUTPUT:
    %       indices - A column vector of indices corresponding to the
    %                 characters in the input string

    % Define the alphabet as a string array
    alphabet = [" ", "A", "B", "C", "D", "E", ...
                "F", "G", "H", "I", "J", "K", ...
                "L", "M", "N", "O", "P", ...
                "Q", "R", "S", "T", "U", "V", ...
                "W", "X", "Y", "Z", ",", "."];

    % Create a mapping from characters to indices
    char_to_index = containers.Map(alphabet, 1:numel(alphabet));


    % Convert the input string to uppercase for consistency
    input_string = upper(input_string); % Ensure the string is uppercase

    input_split=split(input_string,"");

    input_split=input_split(2:length(input_split)-1);

    % Initialize indices array as a column vector
    indices = zeros(length(input_split), 1);

    % Iterate through each character in the input string
    for i = 1:length(input_split)
        char = input_split(i); % Get the i-th character
        if isKey(char_to_index, char)
            indices(i) = char_to_index(char)-1; % Map character to index
        else
            error('Character "%s" not found in the alphabet!', char);
        end
    end
end