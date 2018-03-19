import java.beans {
    constructorProperties
}

native ("jvm")
module com.leo.celox "1.0.0" {
    shared import java.base "8";
    shared import ceylon.buffer "1.3.2";
    shared import ceylon.collection "1.3.0";
}