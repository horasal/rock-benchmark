use std::env;

struct Tree{
    left: Option<Box<Tree>>,
    right: Option<Box<Tree>>,
    item: i32
}

impl Tree{
    pub fn new(depth: i32, i: i32) -> Tree {
        if depth <= 0 { return Tree { item: i , left: None, right: None } } 
        Tree { left: Some(Box::new(Tree::new(depth - 1, 2 * i - 1))), 
            right: Some(Box::new(Tree::new(depth - 1, 2 * i))),
            item: i }
    }

    fn itemCheck(&self) -> i32 {
        let mut sum : i32 = self.item;
        match self.left {
            None => return sum,
            Some(ref p) => { sum += p.itemCheck() } 
        }
        match self.right {
            None => return sum,
            Some(ref p) => { sum -= p.itemCheck() } 
        }
        return sum;
    }
}

fn walkTree(t: Tree) {
    println!("{}", t.item);
    match t.left {
        Some(nt) => { println!("left -> "); walkTree(*nt) }
        None => return
    }

    match t.right {
        Some(nt) => { println!("right -> "); walkTree(*nt) }
        None => return
    }
}


fn main() {
    let mindep = 4;

    let args: Vec<_> = env::args().collect();
    let depth;
    if args.len() > 1 {
        depth = args[1].parse::<i32>().unwrap();
    } else { 
        println!("Parameter missing.");
        return 
    }
    println!("Depth is : {}", depth);

    let stretch = depth + 1;

    let checkTree = Tree::new(stretch, 0);
    println!("stretch tree of depth {}\t check: {}", stretch, checkTree.itemCheck());

    let longLived = Tree::new(depth, 0);

    let mut i = mindep;
    while i <= depth {
        let iterations = 1 << (depth - i + mindep);
        let mut check : i32 = 0;
        for j in 1 .. iterations+1 {
            check += Tree::new(i, j).itemCheck();
            check += Tree::new(i, -j).itemCheck();
        }
        println!("{}\ttrees of depth {}\t check: {}", iterations * 2, i, check);
        i += 2;
    }

    println!("long lived tree of depth {}\t check: {}", depth , longLived.itemCheck());
}
