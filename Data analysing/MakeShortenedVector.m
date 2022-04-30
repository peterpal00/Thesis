function [shortened_vector] = MakeShortenedVector(short_vector_timeline, long_vector_values, long_vector_timeline)
    

%     if short_vector_timeline(1) == 0
%         short_vector_timeline = short_vector_timeline(2:end);
%     end
    actual_timeline_length = length(short_vector_timeline);


    for i = 1:actual_timeline_length
        indexes = find(long_vector_timeline == short_vector_timeline(i));
        shortened_vector(i) = long_vector_values(indexes(1));
    end
end