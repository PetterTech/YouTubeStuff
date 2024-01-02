# Mermaid examples

## Simple flowchart
``` mermaid
flowchart TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
    D-->E; 
```

## Flowchart with lots of connections

``` mermaid
flowchart LR;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
    D-->E;
    E-->A;
    D-->C;
    D-->B;
    E-->B;
    A-->E;
    B-->A;
    B-->E;
```

## Flowchart with some colors and shapes and stuff

``` mermaid
flowchart TD
    A(Christmas) -->|Get money| B(Go shopping)
    style A fill:red,stroke:black,stroke-width:4px,shadow:shadow
    B --> C{Let me think}
    style B fill:green,stroke:black,stroke-width:4px,shadow:shadow
    C -->|One| D[Laptop]
    style C fill:blue,stroke:black,stroke-width:4px,shadow:shadow
    C -->|Two| E[iPhone]
    C -->|Three| F[fa:fa-car Car]
    style D fill:yellow,stroke:black,stroke-width:2px,shadow:shadow
    style E fill:brown,stroke:black,stroke-width:2px,shadow:shadow
    style F fill:navy,stroke:black,stroke-width:2px,shadow:shadow
```

# Simple gantt

``` mermaid
gantt
    title A Gantt Diagram

    Completed task            :done,    task, 2024-01-06,2024-01-08
    Active task               :active,  task2, 2024-01-09, 3d
    Future task               :         task3, after task2, 5d
    Future task2              :         task4, after task3, 5d
```

## Gant with more options

``` mermaid
gantt
    title A Gantt Diagram
    dateFormat  YYYY-MM-DD
    excludes weekends
    
    section Demo Section
    First task  : done,a1, 2023-12-24, 9d
    Second task : active,a2, 2024-01-01, 14d
    Milestone   : milestone, m1, after a2, 0d
    Critical task   : crit,a3, 2024-01-10, 9d
    Last task   : a4,after a2, 8d
    Project end : milestone, m2, 2024-02-02, 0d

    section Help the channel out
    Like      :active,a5,2024-01-5  , 2d
    Comment : a6,after a5, 7d
    Subscribe   : crit,a7,after a6,8d

```

## Pie Chart

``` mermaid
pie 
    showData
    title Pets adopted by volunteers
    "Dogs" : 386
    "Cats" : 85
    "Rats" : 15
```

## Sequence diagram

``` mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail...
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

## Class diagram

``` mermaid
classDiagram
class Animal {
        +name: string
        +age: int
        +makeSound(): void
    }

    class Dog {
        +breed: string
        +bark(): void
    }

    class Cat {
        +color: string
        +meow(): void
    }

    Animal <|-- Dog
    Animal <|-- Cat
```

## Relationship diagram

``` mermaid
erDiagram
    CUSTOMER }|..|{ DELIVERY-ADDRESS : has
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER ||--o{ INVOICE : "liable for"
    DELIVERY-ADDRESS ||--o{ ORDER : receives
    INVOICE ||--|{ ORDER : covers
    ORDER ||--|{ ORDER-ITEM : includes
    PRODUCT-CATEGORY ||--|{ PRODUCT : contains
    PRODUCT ||--o{ ORDER-ITEM : "ordered in"
```

## State diagrams

``` mermaid
stateDiagram-v2
    [*] --> Active

    state Active {
        [*] --> NumLockOff
        NumLockOff --> NumLockOn : EvNumLockPressed
        NumLockOn --> NumLockOff : EvNumLockPressed
        --
        [*] --> CapsLockOff
        CapsLockOff --> CapsLockOn : EvCapsLockPressed
        CapsLockOn --> CapsLockOff : EvCapsLockPressed
        --
        [*] --> ScrollLockOff
        ScrollLockOff --> ScrollLockOn : EvCapsLockPressed
        ScrollLockOn --> ScrollLockOff : EvCapsLockPressed
    }
```
``` mermaid
stateDiagram-v2
    [*] --> Still
    Still --> [*]
    Still --> Moving
    Moving --> Still
    Moving --> Crash
    Crash --> [*]
```

## Flowchart with lots of options and neatly arranged code

``` mermaid
flowchart LR
    id1(Box with round corner)
    id2([Stadium])
    id3[(Database)]
    id4((Circle))
    id5{{Hex}}
    id6[\Parallelogram\]
    id7[\Trapezoid/]

    id1-- 1st line ---id2
    id1--> |2nd line| id3
    id1--- |3rd line| id4
    id2-.-|4th line| id5
    id3 == 5th line ==> id6
    id4 <--> id7 --> id6

    style id1 fill:green,stroke:black
    style id2 fill:white,stroke:#f66,stroke-dasharray: 5, 5
    style id3 fill:#66f,stroke:#f6f,stroke-width:4px
    style id4 fill:red,stroke:yellow
    style id5 fill:orange,stroke:white
    style id6 fill:yellow,stroke:blue
    style id7 fill:brown,stroke:blue
```