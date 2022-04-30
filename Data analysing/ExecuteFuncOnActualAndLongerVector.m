function [result] = ExecuteFuncOnActualAndLongerVector(func, actual_values, actual_timeline, longer_values, longer_timeline)

    shortened_values = MakeShortenedVector(actual_timeline, longer_values, longer_timeline);
    result = func(actual_values, shortened_values);

end