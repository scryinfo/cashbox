use crate::schema::posts;

#[derive(Queryable, Insertable, Debug)]
pub struct Post {
    pub id: i32,
    pub title: String,
    pub body: String,
    pub published: bool,
}
