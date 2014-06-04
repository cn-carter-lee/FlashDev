using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MvcTest.Utility
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.IO;
    using System.Runtime.Serialization.Formatters.Binary;
    using System.ComponentModel;
    using Newtonsoft.Json;
    using Ionic.Zlib;
    using System.Runtime.Serialization;
    using System.Runtime.Serialization.Formatters;
    using System.ComponentModel.DataAnnotations;
    using System.Data;
    using System.Reflection;

    public static class ObjectExtension
    {
        /// <summary>
        /// serialize object to base64String.
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string ToBase64String(this object value)
        {
            string objectMeta;
            using (MemoryStream ms = new MemoryStream())
            {
                BinaryFormatter formatter = new BinaryFormatter();
                formatter.Serialize(ms, value);
                objectMeta = Convert.ToBase64String(ms.ToArray());
            }

            return objectMeta;
        }

        /// <summary>
        /// convert base64String to target type.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="base64String"></param>
        /// <returns></returns>
        public static T ConvertTo<T>(this string base64String)
        {
            try
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    byte[] buffer = Convert.FromBase64String(base64String);
                    ms.Write(buffer, 0, buffer.Length);
                    ms.Seek(0, SeekOrigin.Begin);

                    BinaryFormatter binaryFormatter = new BinaryFormatter();
                    return (T)binaryFormatter.Deserialize(ms);
                }
            }
            catch
            {
                return default(T);
            }
        }

        /// <summary>
        /// Serialize object to json format and compress serialized data
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public static byte[] SerializeToJsonZip(this object value)
        {
            string rawJson = JsonConvert.SerializeObject(value, new JsonSerializerSettings { TypeNameHandling = TypeNameHandling.Objects, TypeNameAssemblyFormat = FormatterAssemblyStyle.Full });
            CompressionLevel compressionLevel = CompressionLevel.None;
            if (rawJson.Length > 60000) compressionLevel = CompressionLevel.BestSpeed;
            return CompressString(rawJson, compressionLevel);
        }

        /// <summary>
        /// Decompress json data and deserialize json data to object
        /// </summary>
        /// <param name="value">compressed json value</param>
        /// <returns></returns>
        public static object DeserializeFromZipJson(this byte[] buffer, bool validateObject = true)
        {
            string unzipJson = UnCompressString(buffer);
            var resultObj = JsonConvert.DeserializeObject(unzipJson, new JsonSerializerSettings { TypeNameHandling = TypeNameHandling.Objects, TypeNameAssemblyFormat = FormatterAssemblyStyle.Full });

            if (!validateObject)
            {
                return resultObj;
            }

            return resultObj.Validate() ? resultObj : null;
        }

        /// <summary>
        /// Compress string value to byte array
        /// </summary>
        /// <param name="value"></param>
        /// <param name="compressionLevel"></param>
        /// <returns></returns>
        private static byte[] CompressString(this String value, CompressionLevel compressionLevel)
        {
            byte[] uncompressed = Encoding.UTF8.GetBytes(value);
            using (var ms = new MemoryStream())
            {
                using (Stream compressor = new GZipStream(ms, CompressionMode.Compress, compressionLevel))
                {
                    compressor.Write(uncompressed, 0, uncompressed.Length);
                }
                return ms.ToArray();
            }
        }

        /// <summary>
        /// Decompress byte arrary to string
        /// </summary>
        /// <param name="byteArray"></param>
        /// <returns></returns>
        private static String UnCompressString(this byte[] byteArray)
        {
            byte[] working = new byte[1024];
            using (var output = new MemoryStream())
            {
                using (var input = new MemoryStream(byteArray))
                {
                    using (Stream decompressor = new GZipStream(input, CompressionMode.Decompress))
                    {
                        int n;
                        while ((n = decompressor.Read(working, 0, working.Length)) != 0)
                        {
                            output.Write(working, 0, n);
                        }
                    }
                    output.Seek(0, SeekOrigin.Begin);
                    var sr = new StreamReader(output, Encoding.UTF8);
                    return sr.ReadToEnd();
                }
            }
        }

        /// <summary>
        /// Validate deserialized object's integrity
        /// </summary>
        /// <param name="validateObj"></param>
        /// <returns></returns>
        public static bool Validate(this object validateObj)
        {
            ValidationContext validationContext = new ValidationContext(validateObj, serviceProvider: null, items: null);
            List<ValidationResult> validationResults = new List<ValidationResult>();
            return Validator.TryValidateObject(validateObj, validationContext, validationResults);
        }

        /// <summary>
        /// convert object as target type.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="value"></param>
        /// <returns></returns>
        public static T As<T>(this object value)
        {
            /*
            / NOTE: Don't change the method name "As", it is used in other projects via reflection
            */
            try
            {
                if (value is T) return (T)value;

                TypeConverter converter = TypeDescriptor.GetConverter(typeof(T));
                if (converter.CanConvertFrom(value.GetType()))
                {
                    return (T)converter.ConvertFrom(value);
                }

                converter = TypeDescriptor.GetConverter(value.GetType());
                if (converter.CanConvertTo(typeof(T)))
                {
                    return (T)converter.ConvertTo(value, typeof(T));
                }
            }
            catch
            {
            }

            return default(T);
        }

        public static string ToRawJson(this object value, JsonSerializerSettings setting = null)
        {
            if (setting == null)
            {
                var jsonSetting = new JsonSerializerSettings();
                jsonSetting.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                jsonSetting.NullValueHandling = NullValueHandling.Ignore;

                return JsonConvert.SerializeObject(value, jsonSetting);
            }

            return JsonConvert.SerializeObject(value, setting);
        }

        public static T DeepCopy<T>(this T source) where T : class
        {
            using (MemoryStream memoryStream = new MemoryStream())
            {
                BinaryFormatter binaryFormatter = new BinaryFormatter();
                binaryFormatter.Serialize(memoryStream, source);
                memoryStream.Seek(0, SeekOrigin.Begin);

                return (T)binaryFormatter.Deserialize(memoryStream);
            }
        }

        /// <summary>
        ///  Capitalize the first letter of each word. Lower case for all other letters
        /// </summary>
        /// <param name="value"></param>
        /// <param name="flag">if true, treat a two letter string as an abbreviation (e.g. CN for China), else no abbreviation</param>
        /// <returns></returns>
        public static string ToTitleCase(this string value, bool flag = false)
        {
            value = value.Trim();
            if (flag && value.Length < 3)
            {
                //'aa' will to change to 'AA'
                return value.ToUpper();
            }
            else
            {
                //if there's no ToLower 'AAA' will to change to 'Aaa'
                return System.Globalization.CultureInfo.GetCultureInfo("en-US").TextInfo.ToTitleCase(value.ToLower());
            }
        }
    }
}
