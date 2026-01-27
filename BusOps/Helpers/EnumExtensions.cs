using System.ComponentModel.DataAnnotations;

namespace BusOps.Helpers;

public static class EnumExtensions
{
    public static string GetDisplayName<T>(this T value) where T : Enum
    {
        var fieldInfo = value.GetType().GetField(value.ToString());
        if (fieldInfo == null) return value.ToString();
        
        var displayAttribute = (DisplayAttribute?)Attribute.GetCustomAttribute(fieldInfo, typeof(DisplayAttribute));
        return displayAttribute?.Name ?? value.ToString();
    }
}
