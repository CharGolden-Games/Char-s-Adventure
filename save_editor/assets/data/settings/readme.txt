You can make your own custom settings here!

Format:
```
{
    "settings": [
        {
            "title": "Test Option Bool",
            "icon": "icon/path/here",
            "type": "bool",
            "defaultValue": false
        },
        {
            "title": "Test Option Enum",
            "icon": "icon/path/here",
            "type": "enum",
            "defaultValue": "Test1",
            "enumValues": [
                "Test1",
                "Test2",
                "Test3"
            ]
        },
        {
            "title": "Test Option Float",
            "icon": "icon/path/here",
            "type": "float",
            "defaultValue": 1,
            "min": 0,
            "max": 1,
            "precision": 0.1
        }
    ]
}
```