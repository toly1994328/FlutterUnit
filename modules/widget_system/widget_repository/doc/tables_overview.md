# 数据表结构总览

## 核心表 (6张)

### 1. widget - Widget基本信息
```sql
CREATE TABLE widget(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    path TEXT NOT NULL,
    is_abstract INTEGER NOT NULL DEFAULT 0,
    is_private INTEGER NOT NULL DEFAULT 0,
    deprecated INTEGER DEFAULT 0,
    family INTEGER NOT NULL,
    lever FLOAT(2) NOT NULL,
    linkWidget TEXT DEFAULT ''
);
```

### 2. widget_inheritance - Widget继承关系
```sql
CREATE TABLE widget_inheritance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    widget_id INTEGER NOT NULL,
    parent_name TEXT NOT NULL,
    inheritance_order INTEGER NOT NULL
);
```

### 3. widget_fields - Widget字段信息
```sql
CREATE TABLE widget_fields (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    widget_id INTEGER NOT NULL,
    field_name TEXT NOT NULL,
    field_type TEXT NOT NULL,
    field_desc TEXT,
    field_desc_zh TEXT,
    field_order INTEGER NOT NULL,
    is_required INTEGER NOT NULL DEFAULT 0
);
```

### 4. widget_desc - Widget描述信息
```sql
CREATE TABLE widget_desc(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    widget_id INTEGER NOT NULL,
    name VARCHAR(128) NOT NULL,
    info TEXT NOT NULL,
    locale VARCHAR(16) DEFAULT 'zh-cn'
);
```

### 5. node - 示例代码节点
```sql
CREATE TABLE node(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    widgetId INTEGER NOT NULL,
    priority INTEGER DEFAULT 0,
    code TEXT NOT NULL
);
```

### 6. node_desc - 节点描述信息
```sql
CREATE TABLE node_desc(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    node_id INTEGER NOT NULL,
    name VARCHAR(128) NOT NULL,
    subtitle TEXT NOT NULL,
    locale VARCHAR(16) DEFAULT 'zh-cn'
);
```

## 扩展表 (2张)

### 7. category - Widget分类
```sql
CREATE TABLE category(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    type INTEGER DEFAULT 0,
    color VARCHAR(9) DEFAULT '#FF2196F3',
    info VARCHAR(256) DEFAULT '这里什么都没有...',
    created DATETIME NOT NULL,
    updated DATETIME NOT NULL,
    priority INTEGER DEFAULT 0,
    image VARCHAR(128) DEFAULT ''
);
```

### 8. category_widget - 分类Widget关联
```sql
CREATE TABLE category_widget(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    categoryId INTEGER NOT NULL,
    widgetId INTEGER NOT NULL
);
```

## 表关系图
```
widget (1) ←→ (N) widget_inheritance
widget (1) ←→ (N) widget_fields  
widget (1) ←→ (N) widget_desc
widget (1) ←→ (N) node
node (1) ←→ (N) node_desc
widget (N) ←→ (N) category [through category_widget]
```