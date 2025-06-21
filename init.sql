-- Create tables
CREATE TABLE "User" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR NOT NULL UNIQUE,
    "email" VARCHAR NOT NULL UNIQUE,
    "password" VARCHAR NOT NULL,
    "avatar" VARCHAR,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Book" (
    "id" SERIAL PRIMARY KEY,
    "slug" VARCHAR NOT NULL UNIQUE,
    "name" VARCHAR NOT NULL,
    "cover" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Word" (
    "id" SERIAL PRIMARY KEY,
    "bookSlug" VARCHAR NOT NULL REFERENCES "Book"("slug"),
    "slug" VARCHAR NOT NULL UNIQUE,
    "word" VARCHAR NOT NULL,
    "usPronounce" VARCHAR NOT NULL,
    "ukPronounce" VARCHAR NOT NULL,
    "remember" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Cognate" (
    "id" SERIAL PRIMARY KEY,
    "wordSlug" VARCHAR NOT NULL REFERENCES "Word"("slug"),
    "pos" VARCHAR NOT NULL,
    "content" VARCHAR NOT NULL,
    "transCn" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Phrase" (
    "id" SERIAL PRIMARY KEY,
    "wordSlug" VARCHAR NOT NULL REFERENCES "Word"("slug"),
    "content" VARCHAR NOT NULL,
    "transCn" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Sentence" (
    "id" SERIAL PRIMARY KEY,
    "wordSlug" VARCHAR NOT NULL REFERENCES "Word"("slug"),
    "content" VARCHAR NOT NULL,
    "transCn" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Synonym" (
    "id" SERIAL PRIMARY KEY,
    "wordSlug" VARCHAR NOT NULL REFERENCES "Word"("slug"),
    "pos" VARCHAR NOT NULL,
    "content" VARCHAR NOT NULL,
    "transCn" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Translation" (
    "id" SERIAL PRIMARY KEY,
    "wordSlug" VARCHAR NOT NULL REFERENCES "Word"("slug"),
    "pos" VARCHAR NOT NULL,
    "transCn" VARCHAR NOT NULL,
    "transEn" VARCHAR NOT NULL,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "Verify" (
    "id" SERIAL PRIMARY KEY,
    "email" VARCHAR NOT NULL UNIQUE,
    "code" VARCHAR,
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "UsersToBooks" (
    "userId" INTEGER NOT NULL REFERENCES "User"("id"),
    "bookSlug" VARCHAR NOT NULL REFERENCES "Book"("slug"),
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY ("userId", "bookSlug")
);

CREATE TABLE "UsersToWords" (
    "userId" INTEGER NOT NULL REFERENCES "User"("id"),
    "wordSlug" VARCHAR NOT NULL REFERENCES "Word"("slug"),
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY ("userId", "wordSlug")
);

CREATE TABLE "Post" (
    "id" SERIAL PRIMARY KEY,
    "content" TEXT NOT NULL,
    "userId" INTEGER NOT NULL REFERENCES "User"("id"),
    "wordSlug" VARCHAR NOT NULL REFERENCES "Word"("slug"),
    "parentPostId" INTEGER REFERENCES "Post"("id"),
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "UsersToPostsVote" (
    "userId" INTEGER NOT NULL REFERENCES "User"("id"),
    "postId" INTEGER NOT NULL REFERENCES "Post"("id"),
    "createdAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updatedAt" TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY ("userId", "postId")
); 