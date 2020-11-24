<cfcomponent extends="Model" output="false">
<cfscript>

  function config(){
    table("fgbc_content")
    validatesPresenceOf("author")
    validatesPresenceOf("content")
    validatesPresenceOf("name")
  }

  public function findFootnotesAsStruct(){
  var footnotes = {};
    footnotes.1='John 1:1.14';
    footnotes.2='Matthew 5:17.18; 2Timothy 3:16; 2Peter 1:20.21; Psalm 19:7-11';
    footnotes.3='John 14:6; Acts 4:12; 1Corinthians 12:3; Romans 10:9; Philippians 2:9-11';
    footnotes.4='Deuteronomy 6:4; Isaiah 43:10; 1Corinthians 8:4-6; 1Timothy 2:5';
    footnotes.5='Matthew 22:32; Acts 3:13';
    footnotes.6='Genesis 1:1; Psalm 146:6; John 1:3; Colossians 1:16.17';
    footnotes.7='Matthew 28:19; Luke 3:22; 2Corinthians 13.14';
    footnotes.8='John 1:1-3; John 8:58; Titus 2:13';
    footnotes.9='Romans 11:36; Colossians 1:16';
    footnotes.10='John 1:14; Matthew 1:18-23; Luke 1:29-35';
    footnotes.11='Luke 2:52; John 19:28; Philippians 2:6-8';
    footnotes.12='Hebrews 4:15; 1Peter 2:22';
    footnotes.13='Romans 5:8; 2Corinthians 5:21; 1Peter 2:24.25';
    footnotes.14='Luke 24:36-43; Romans 1:4; 1Corinthians 15:3-8';
    footnotes.15='Acts 1:9; Hebrews 4:14';
    footnotes.16='Ephesians 1:19-23; Hebrews 4:15.16';
    footnotes.17='Acts 1:11';
    footnotes.18='Acts 5:3.4';
    footnotes.19='John 16:7-15';
    footnotes.20='Genesis 1:2';
    footnotes.21='2Peter 1:21';
    footnotes.22='John 16:8-11';
    footnotes.23='Titus 3:5';
    footnotes.24='Ephesians 5:18';
    footnotes.25='Galatians 5:16';
    footnotes.26='Galatians 5:22.23; Ephesians 3:16-21; Acts 1:8';
    footnotes.27='Luke 24:25-27; 1Peter 1:23-25';
    footnotes.28='2Timothy 3:16; 2Peter 1:20.21';
    footnotes.29='Psalm 19:7-11';
    footnotes.30='Psalm 119:89; Psalm 119:160';
    footnotes.31='Romans 1:16; Romans 10:8-17; Romans 16:25-27';
    footnotes.32='1Corinthians 2:9-16; Ephesians 1:17-23';
    footnotes.33='Genesis 1:26-28';
    footnotes.34='James 3:9';
    footnotes.35='Genesis 3:1-24';
    footnotes.36='Romans 5:12.19';
    footnotes.37='Romans 6:23; Ephesians 2:1-3';
    footnotes.38='Romans 8:6-8';
    footnotes.39='Genesis 2:17; Romans 5:12';
    footnotes.40='John 1:12; John 3:3-5';
    footnotes.41='Romans 5:1; Ephesians 2:4-9; Titus 3:5-7; 1Peter 1:18-21; Hebrews 9:12; Hebrews 10:14';
    footnotes.42='1Peter 4:17; Ephesians 2:19.20; 1Timothy 3:14.15';
    footnotes.43='1Corinthians 12:27; Ephesians 1:22.23';
    footnotes.44='1Corinthians 3:16; Ephesians 1:21.22';
    footnotes.45='1Corinthians 12:13';
    footnotes.46='Hebrews 10:25; Galatians 1:2; Romans 16;4.5; Revelation 2:1.8.12.18; Revelation 3:1.7.14';
    footnotes.47='Romans 4:5';
    footnotes.48='Romans 1:5';
    footnotes.49='James 2:14-17; Titus 3:8';
    footnotes.50='Galatians 5:22.23';
    footnotes.51='Matthew 22:37-40; Colossians 3:17';
    footnotes.52='Philippians 1:6; Philippians 2:12-13';
    footnotes.53='Romans 8:29; 2Corinthians 3:18';
    footnotes.54='Daniel 7:10; Hebrews 12:22';
    footnotes.55='Hebrews 1:14; Ephesians 1:21; Ephesians 3:10';
    footnotes.56='1Peter 5:8.9; Revelation 12:1-10';
    footnotes.57='Ephesians 6:12';
    footnotes.58='1John 3:8';
    footnotes.59='John 12:31; Romans 16:20; Revelation 2:10';
    footnotes.60='Philippians 1:21-23; Luke 16:19-31';
    footnotes.61='John 5:28.29';
    footnotes.62='Matthew 25:46; Revelation 20:15';
    footnotes.63='John 3:16; John 6:47';
    footnotes.64='Romans 14:10-12; 1Corinthians 3:10-15; 2Corinthians 5:10';
    footnotes.65='1Thessalonians 4:17; Revelation 21:3-5; Psalm 16:11';
    footnotes.66='Matthew 5:18; Luke 24:25-27';
    footnotes.67='1Corinthians 2:14';
    footnotes.68='1Corinthians 4:6';
    footnotes.69='Acts 17:11; 2Timothy 2:15; 1Chronicles 12:32';
    footnotes.70='John 10:28.29; 1Peter 1:3-5';
    footnotes.71='Romans 3:24; Romans 4:25';
    footnotes.72='Ephesians 1:3';
    footnotes.73='Romans 8:1';
    footnotes.74='1Corinthians 12:13';
    footnotes.75='Ephesians 1:13';
    footnotes.76='Romans 8:11';
    footnotes.77='Romans 12:6; 1Corinthians 12:7.11';
    footnotes.78='Matthew 28:19; Acts 8:36-38; Acts 10:47';
    footnotes.79='1Corinthians 11:20.23-26; Luke 22:14-20; John 13:14; Jude 12';
    footnotes.80='James 5:13-16';
    footnotes.81='1Timothy 4:14';
    footnotes.82='Acts 2:1; Acts 2:37-47';
    footnotes.83='1Thessalonians 4:16.17; John 14:3';
    footnotes.84='Zechariah 12; Romans 11:26-29';
    footnotes.85='Acts 1:11; Zechariah 14:4';
    footnotes.86='Revelation 19:11-16 ; Colossians 3:4';
    footnotes.87='Revelation 20:4';
    footnotes.88='1Corinthians 15:24.25';
    footnotes.89='John 17:20.21';
    footnotes.90='Ephesians 4:1-6';
    footnotes.91='1Peter 4:10';
    footnotes.92='Romans 12:3-8; 1Corinthians 12:12-27';
    footnotes.93='The New Testament has over twenty &##39;one another&##39; references. Compare James 5:16; Galatians 5:13 et al.';
    footnotes.94='1Cor 5:12.13';
    footnotes.95='1Corinthians 11:16';
    footnotes.96='Compare Acts 18:24-28; Romans 15:24-29';
    footnotes.97='Matthew 28:18-20; Romans 1:5';
    footnotes.98='Romans 10:13-17; 1Corinthians 15:3-4; 2Corinthians 5:18-20; Galatians 5:16';
    footnotes.99='Acts 13:2.3';
    footnotes.100='1Timothy 4:6';
    footnotes.101='Acts 20:28; 1Peter 5:2';
    footnotes.102='1Corinthians 4:1';
    footnotes.103='Acts 2:41-47; Acts 14:21-28';
    footnotes.104='1John 3:16-18';
    footnotes.105='Acts 10:38; Titus 3:8; James 2:1-9';
  return footnotes;
  }

</cfscript>

</cfcomponent>