Exploring code

The values returned by the various faker domain data generators are defined in the locales JavaScript files that live under node-modules/faker/lib/locales. For each supported locale, a language and region specific instance of a library file is defined that contains the localized values returned by the corresponding module. 

![](assets/faker-locales.png)

For example file *faker/lib/locales/de/name/first_name.js* contains the German set of first names that are used in module *faker/lib/name*, overriding the default values in *faker/lib/locales/en/name/first_name.js* in case the local is set to *de*

