// clang main.m -O3 -framework Foundation -o objcmain

#import<Foundation/Foundation.h>

int main(int argc, char** argv)
{
    NSMutableArray *array = [NSMutableArray array];
    
    for(NSInteger i = 0; i < 1000000; ++i) {
        array[i] = @((double)i * (double)i);
    }
    
    NSLog(@"%lu iterations", (unsigned long)array.count);
        
    return 0;
}
